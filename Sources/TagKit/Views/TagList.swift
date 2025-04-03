//
//  TagList.swift
//  TagKit
//
//  Based on https://github.com/globulus/swiftui-flow-layout
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum specifies supported tag list container types.
public enum TagListContainer {

    case scrollView, vstack
}

/// This view can be used to list a collection of tags.
///
/// The view takes a list of tags and renders them using the
/// provided `tagView`  builder. It will not slugify the tag
/// elements, so either provide already slugified strings or
/// slugify them in the view builder.
///
/// Note that this list only renders the tag views. You must
/// specify the container in which they will be rendered.
public struct TagList<TagView: View>: View {

    /// Create a tag list.
    ///
    /// - Parameters:
    ///   - tags: The items to render in the layout.
    ///   - container: The container type, by default `.scrollView`.
    ///   - horizontalSpacing: The horizontal spacing between items.
    ///   - verticalSpacing: The vertical spacing between items.
    ///   - tagView: The item view builder.
    public init(
        tags: [String],
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.tags = tags
        self.tagView = tagView
    }

    private let tags: [String]

    @ViewBuilder
    private let tagView: TagViewBuilder

    /// This type defines the tag view builder for the list.
    public typealias TagViewBuilder = (_ tag: String) -> TagView

    public var body: some View {
        ForEach(Array(tags.enumerated()), id: \.offset) {
            tagView($0.element)
        }
    }
}

#Preview {

    ScrollView {
        TagList(tags: [
            "A long tag here",
            "Another long tag here",
            "A", "bunch", "of", "short", "tags"
        ]) { tag in
            Text(tag.slugified())
                .font(.system(size: 12))
                .foregroundColor(.black)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green, in: .rect(cornerRadius: 5))
        }
        .padding()
    }
}
