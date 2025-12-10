import SwiftUI

/// The way line breaking treats flexible items. The default behavior is `.natural`.
enum FlexibilityBehavior: Sendable {
    /// The layout chooses the minimum space for the view, regardless of how much it can expand
    case minimum
    /// The layout allows the views to exapand as they naturally do.
    case natural
    /// If a view can expand, it allows to "push" out other views and fill a whole row on its own.
    case maximum
}

/// Cache to store certain properties of subviews in the layout (flexibility, spacing preferences, layout priority).
/// Even though it needs to be (because it's part of the layout protocol conformance),
/// it's considered an internal implementation detail.
struct FlowLayoutCache {
    struct SubviewCache {
            var priority: Double
            var spacing: ViewSpacing
            var min: Size
            var ideal: Size
            var max: Size
            var layoutValues: LayoutValues
            struct LayoutValues {
                    var shouldStartInNewLine: Bool
                    var isLineBreak: Bool
                    var flexibility: FlexibilityBehavior

                    init(shouldStartInNewLine: Bool, isLineBreak: Bool, flexibility: FlexibilityBehavior) {
                self.shouldStartInNewLine = shouldStartInNewLine
                self.isLineBreak = isLineBreak
                self.flexibility = flexibility
            }
        }

            init(_ subview: some Subview, axis: Axis) {
            priority = subview.priority
            spacing = subview.spacing
            min = subview.dimensions(.zero).size(on: axis)
            ideal = subview.dimensions(.unspecified).size(on: axis)
            max = subview.dimensions(.infinity).size(on: axis)
            layoutValues = LayoutValues(
                shouldStartInNewLine: subview[ShouldStartInNewLineLayoutValueKey.self],
                isLineBreak: subview[IsLineBreakLayoutValueKey.self],
                flexibility: subview[FlexibilityLayoutValueKey.self]
            )
        }
    }

    @usableFromInline 
    let subviewsCache: [SubviewCache]

    @inlinable 
    init(_ subviews: some Subviews, axis: Axis) {
        subviewsCache = subviews.map {
            SubviewCache($0, axis: axis)
        }
    }
}

/// A view to manually insert breaks into flow layout, allowing precise control over line breaking.
struct LineBreak: View {
    /// Initializes a new line break view
    init() {}

    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .layoutValue(key: IsLineBreakLayoutValueKey.self, value: true)
    }
}

extension View {
    /// Allows flow layout elements to be started on new lines, allowing precise control over line breaking.
    func startInNewLine(_ enabled: Bool = true) -> some View {
        layoutValue(key: ShouldStartInNewLineLayoutValueKey.self, value: enabled)
    }

    /// Allows modifying the flexibility behavior of views so that flow can layout them accordingly.
    /// This modifier can be placed outside of flow layout too, and propagate to all flow layouts inside that view tree (using environment).
    /// The default flexibility of each item in a flow is `.natural`.
    func flexibility(_ behavior: FlexibilityBehavior) -> some View {
        layoutValue(key: FlexibilityLayoutValueKey.self, value: behavior)
            .environment(\.flexibility, behavior)
    }
}

struct ShouldStartInNewLineLayoutValueKey: LayoutValueKey {
    static let defaultValue = false
}

struct IsLineBreakLayoutValueKey: LayoutValueKey {
    static let defaultValue = false
}

struct FlexibilityLayoutValueKey: LayoutValueKey {
    static let defaultValue: FlexibilityBehavior = .natural
}

struct FlexibilityEnvironmentKey: EnvironmentKey {
    static let defaultValue: FlexibilityBehavior = .natural
}

extension EnvironmentValues {
    var flexibility: FlexibilityBehavior {
        get { self[FlexibilityEnvironmentKey.self] }
        set { self[FlexibilityEnvironmentKey.self] = newValue }
    }
}
