//
//  FlowLayout.swift
//  TagKit
//
//  Based on https://github.com/globulus/swiftui-flow-layout
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view lists data in a leading to trailing flow.
///
/// The view will break to a new line whenever the view does
/// not fit on the current line.
///
/// You must specify a container type, since the view has to
/// be rendered differently depending on in the container it
/// is used in, e.g.  `ScrollView`, `VStack`, etc.
public struct FlowLayout<ItemType, ItemView: View>: View {

    /// Create a flow layout.
    ///
    /// - Parameters:
    ///   - container: The container type.
    ///   - items: The items to render in the layout.
    ///   - horizontalSpacing: The horizontal spacing between items.
    ///   - verticalSpacing: The vertical spacing between items.
    ///   - itemView: The item view builder.
    public init(
        container: ContainerType,
        items: [ItemType],
        horizontalSpacing: CGFloat = 5,
        verticalSpacing: CGFloat = 5,
        @ViewBuilder itemView: @escaping (ItemType) -> ItemView
    ) {
        self.container = container
        self.items = items
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.itemView = itemView
        let initialHeight: CGFloat = container == .scrollView ? .zero : .infinity
        _totalHeight = State(initialValue: initialHeight)
    }

    private let container: ContainerType
    private let items: [ItemType]
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    @ViewBuilder
    private let itemView: (ItemType) -> ItemView

    /// This enum specifies all supported container types.
    public enum ContainerType {

        case scrollView, vstack
    }

    @State
    private var totalHeight: CGFloat

    public var body: some View {
        if container == .scrollView {
            content.frame(height: totalHeight)
        } else {
            content.frame(maxHeight: totalHeight)
        }
    }
}

@MainActor
private extension FlowLayout {

    var content: some View {
        GeometryReader { geometry in
            content(in: geometry.size)
        }
    }

    func content(in size: CGSize) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero
        let itemCount = items.count
        let itemVews = items.enumerated().map { element in
            let index = element.offset
            let item = element.element
            itemView(item)
                .padding([.horizontal], horizontalSpacing)
                .padding([.vertical], verticalSpacing)
                .alignmentGuide(.leading, computeValue: { d in
                    if abs(width - d.width) > size.width {
                        width = 0
                        height -= lastHeight
                    }
                    lastHeight = d.height
                    let result = width
                    if index == itemCount - 1 {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = height
                    if index == itemCount - 1 {
                        height = 0
                    }
                    return result
                })
        }
        
        
        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                itemView(item)
                    .padding([.horizontal], horizontalSpacing)
                    .padding([.vertical], verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > size.width {
                            width = 0
                            height -= lastHeight
                        }
                        lastHeight = d.height
                        let result = width
                        if index == itemCount - 1 {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if index == itemCount - 1 {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return .clear
        }
    }
}

#Preview {

    FlowLayout(
        container: .scrollView,
        items: ["A long text here", "Another long text here",
                "A", "bunch", "of", "short", "texts", "in", "a", "row",
                "And then a very very very long long long long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long long long one",
                "and", "then", "some", "more", "short", "ones"
               ]
    ) {
        Text($0)
            .font(.footnote)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(.red, in: .rect(cornerRadius: 8))
    }
    .padding()
}
