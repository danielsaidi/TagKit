import CoreFoundation
import SwiftUI

struct Size: Sendable {
    var breadth: CGFloat
    var depth: CGFloat

    init(breadth: CGFloat, depth: CGFloat) {
        self.breadth = breadth
        self.depth = depth
    }

    static let zero = Size(breadth: 0, depth: 0)

    subscript(axis: Axis) -> CGFloat {
        get {
            self[keyPath: keyPath(on: axis)]
        }
        set {
            self[keyPath: keyPath(on: axis)] = newValue
        }
    }

    func keyPath(on axis: Axis) -> WritableKeyPath<Size, CGFloat> {
        switch axis {
            case .horizontal: \.breadth
            case .vertical: \.depth
        }
    }
}

extension Axis {
    var perpendicular: Axis {
        switch self {
            case .horizontal: .vertical
            case .vertical: .horizontal
        }
    }
}

// MARK: Fixed orientation -> orientation independent

protocol FixedOrientation2DCoordinate {
    init(size: Size, axis: Axis)
    func value(on axis: Axis) -> CGFloat
}

extension FixedOrientation2DCoordinate {
    func size(on axis: Axis) -> Size {
        Size(breadth: value(on: axis), depth: value(on: axis.perpendicular))
    }
}

extension CGPoint: FixedOrientation2DCoordinate {
    init(size: Size, axis: Axis) {
        self.init(x: size[axis], y: size[axis.perpendicular])
    }

    func value(on axis: Axis) -> CGFloat {
        switch axis {
            case .horizontal: x
            case .vertical: y
        }
    }
}

extension CGSize: FixedOrientation2DCoordinate {
    init(size: Size, axis: Axis) {
        self.init(width: size[axis], height: size[axis.perpendicular])
    }

    func value(on axis: Axis) -> CGFloat {
        switch axis {
            case .horizontal: width
            case .vertical: height
        }
    }

    static var infinity: CGSize {
        CGSize(
            width: CGFloat.infinity,
            height: CGFloat.infinity
        )
    }
}

extension ProposedViewSize: FixedOrientation2DCoordinate {
    init(size: Size, axis: Axis) {
        self.init(width: size[axis], height: size[axis.perpendicular])
    }

    func value(on axis: Axis) -> CGFloat {
        switch axis {
            case .horizontal: width ?? .infinity
            case .vertical: height ?? .infinity
        }
    }
}

extension CGRect {
    func minimumValue(on axis: Axis) -> CGFloat {
        switch axis {
            case .horizontal: minX
            case .vertical: minY
        }
    }

    func maximumValue(on axis: Axis) -> CGFloat {
        switch axis {
            case .horizontal: maxX
            case .vertical: maxY
        }
    }
}
