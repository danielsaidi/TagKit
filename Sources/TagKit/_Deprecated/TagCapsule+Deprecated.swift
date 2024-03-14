import Foundation

public extension TagCapsule {
    
    @available(*, deprecated, message: "Use .init(_:isSelected:) instead and apply the style with the .tagCapsuleStyle modifier.")
    init(
        tag: String,
        style: TagCapsuleStyle
    ) {
        self.init(tag)
    }
}
