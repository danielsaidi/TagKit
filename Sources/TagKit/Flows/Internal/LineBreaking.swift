import CoreFoundation
import Foundation

struct LineItemInput {
    var size: ClosedRange<CGFloat>
    var spacing: CGFloat
    var priority: Double = 0
    var flexibility: FlexibilityBehavior = .natural
    var isLineBreakView: Bool = false
    var shouldStartInNewLine: Bool = false
    var growingPotential: Double {
        if flexibility == .minimum {
            return 0
        } else {
            return size.upperBound - size.lowerBound
        }
    }
}

protocol LineBreaking {
    func wrapItemsToLines(items: LineBreakingInput, in availableSpace: CGFloat) -> LineBreakingOutput
}

typealias LineBreakingInput = [LineItemInput]

typealias IndexedLineBreakingInput = [(offset: Int, element: LineItemInput)]

typealias LineBreakingOutput = [LineOutput]

typealias LineOutput = [LineItemOutput]

struct LineItemOutput: Equatable {
    let index: Int
    var size: CGFloat
    var leadingSpace: CGFloat

    init(index: Int, size: CGFloat, leadingSpace: CGFloat) {
        self.index = index
        self.size = size
        self.leadingSpace = leadingSpace
    }
}

struct FlowLineBreaker: LineBreaking {
    init() {}

    func wrapItemsToLines(items: LineBreakingInput, in availableSpace: CGFloat) -> LineBreakingOutput {
        var currentLine: IndexedLineBreakingInput = []
        var lines: LineBreakingOutput = []

        for item in items.enumerated() {
            if sizes(of: currentLine + [item], availableSpace: availableSpace) != nil {
                currentLine.append(item)
            } else if let line = sizes(of: currentLine, availableSpace: availableSpace)?.items {
                lines.append(line)
                currentLine = [item]
            }
        }
        if let line = sizes(of: currentLine, availableSpace: availableSpace)?.items {
            lines.append(line)
        }
        return lines
    }
}

struct KnuthPlassLineBreaker: LineBreaking {
    init() {}

    func wrapItemsToLines(items: LineBreakingInput, in availableSpace: CGFloat) -> LineBreakingOutput {
        if items.isEmpty {
            return []
        }
        let count = items.count
        var costs: [CGFloat] = Array(repeating: .infinity, count: count + 1)
        var breaks: [Int?] = Array(repeating: nil, count: count + 1)

        costs[0] = 0

        for end in 1 ... count {
            for start in (0 ..< end).reversed() {
                let itemsToEvaluate: IndexedLineBreakingInput = (start ..< end).map { ($0, items[$0]) }
                guard let calculation = sizes(of: itemsToEvaluate, availableSpace: availableSpace) else { continue }
                let remainingSpace = calculation.remainingSpace
                let spacePenalty = remainingSpace * remainingSpace
                let stretchPenalty = zip(itemsToEvaluate, calculation.items).sum { item, calculation in
                    let deviation = calculation.size - item.element.size.lowerBound
                    return deviation * deviation
                }
                let bias = CGFloat(count - start) * 5 // Introduce a small bias to prefer breaks that fill earlier lines more
                let cost = costs[start] + spacePenalty + stretchPenalty + bias
                if cost < costs[end] {
                    costs[end] = cost
                    breaks[end] = start
                }
            }
        }

        var result: LineBreakingOutput = []
        var end = items.count
        while let start = breaks[end] {
            let line = sizes(of: (start..<end).map { ($0, items[$0]) }, availableSpace: availableSpace)?.items ?? (start..<end).map { index in
                LineItemOutput(
                    index: index,
                    size: items[index].size.lowerBound,
                    leadingSpace: index == start ? 0 : items[index].spacing
                )
            }
            result.insert(line, at: 0)
            end = start
        }
        return result
    }
}

typealias SizeCalculation = (items: LineOutput, remainingSpace: CGFloat)

func sizes(of items: IndexedLineBreakingInput, availableSpace: CGFloat) -> SizeCalculation? {
    if items.isEmpty {
        return nil
    }
    // Handle line break view
    let positionOfLineBreak = items.lastIndex(where: \.element.isLineBreakView)
    if let positionOfLineBreak, positionOfLineBreak > 0 {
        return nil
    }
    var items = items
    if let positionOfLineBreak, case let afterLineBreak = items.index(after: positionOfLineBreak), afterLineBreak < items.endIndex {
        items[afterLineBreak].element.spacing = 0
    }
    // Handle manual new line modifier
    let numberOfNewLines = items.filter(\.element.shouldStartInNewLine).count
    if numberOfNewLines > 1 {
        return nil
    } else if numberOfNewLines == 1, !items[0].element.shouldStartInNewLine {
        return nil
    }
    // Calculate total size
    let totalSizeOfItems = items.sum(of: \.element.size.lowerBound) + items.dropFirst().sum(of: \.element.spacing)
    if totalSizeOfItems > availableSpace {
        return nil
    }
    var remainingSpace = availableSpace - totalSizeOfItems
    // Handle expanded items
    for item in items where item.element.flexibility == .maximum {
        let size = max(item.element.size.lowerBound, min(availableSpace, item.element.size.upperBound))
        if size - item.element.size.lowerBound > remainingSpace {
            return nil
        }
    }
    // Layout accoring to priorities and proportionally distribute remaining space between flexible views
    var result: LineOutput = items.map { LineItemOutput(index: $0.offset, size: $0.element.size.lowerBound, leadingSpace: $0.element.spacing) }
    result[0].leadingSpace = 0
    let itemsInPriorityOrder = Dictionary(grouping: items.enumerated(), by: \.element.element.priority)
    let priorities = itemsInPriorityOrder.keys.sorted(by: >)
    for priority in priorities where remainingSpace > 0 {
        let items = itemsInPriorityOrder[priority] ?? []
        let itemsInFlexibilityOrder = items.sorted(using: KeyPathComparator(\.element.element.growingPotential))
        var remainingItemCount = items.count
        for (index, item) in itemsInFlexibilityOrder {
            let offer = remainingSpace / CGFloat(remainingItemCount)
            let allocation = min(item.element.growingPotential, offer)
            result[index].size += allocation
            remainingSpace -= allocation
            remainingItemCount -= 1
        }
    }
    return SizeCalculation(items: result, remainingSpace: remainingSpace)
}
