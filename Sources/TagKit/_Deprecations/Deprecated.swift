import SwiftUI

@available(*, deprecated, renamed: "TagToggleList")
public typealias TagEditList = TagToggleList

public extension Tagged {

    @available(*, deprecated, renamed: "slugifiedTags(withConfiguration:)")
    func slugifiedTags(
        configuration: SlugConfiguration = .standard
    ) -> [String] {
        slugifiedTags(withConfiguration: configuration)
    }
}
