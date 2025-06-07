import SwiftUI

extension TagList {
    
    @available(*, deprecated, message: "The container parameter is no longer used")
    public init(
        tags: [String],
        container: TagListContainer,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The container and spacing parameters are no longer used")
    public init(
        tags: [String],
        container: TagListContainer,
        horizontalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The container and spacing parameters are no longer used")
    public init(
        tags: [String],
        container: TagListContainer,
        verticalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The spacing parameter is no longer used")
    public init(
        tags: [String],
        horizontalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The spacing parameter is no longer used")
    public init(
        tags: [String],
        verticalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            tagView: tagView
        )
    }
}

extension TagEditList {
    
    @available(*, deprecated, message: "The container parameter is no longer used")
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        container: TagListContainer,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            additionalTags: additionalTags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The container and spacing parameters are no longer used")
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        container: TagListContainer,
        horizontalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            additionalTags: additionalTags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The container and spacing parameters are no longer used")
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        container: TagListContainer,
        verticalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            additionalTags: additionalTags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The spacing parameter is no longer used")
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        horizontalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            additionalTags: additionalTags,
            tagView: tagView
        )
    }
    
    @available(*, deprecated, message: "The spacing parameter is no longer used")
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        verticalSpacing: CGFloat,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.init(
            tags: tags,
            additionalTags: additionalTags,
            tagView: tagView
        )
    }
}
