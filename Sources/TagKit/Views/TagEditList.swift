//
//  TagEditList.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to list a collection of tags, with
/// a custom `tagView` builder.
///
/// The view allows you to tap tags to toggle them on or off.
/// It will list all tags in the provided binding as well as
/// a list of `additionalTags` that should be listed even if
/// they are not in the `tags` collection.
///
/// You can apply a ``SwiftUICore/View/tagFlow(_:)`` to this
/// view, to make tags flow horizontally or vertically.
///
/// > Note: The view doesn't slugify the strings you provide,
/// so make to do so beforehand.
public struct TagEditList<TagView: View>: View {

    /// Create a tag edit list.
    ///
    /// - Parameters:
    ///   - tags: The items to render in the layout.
    ///   - additionalTags: Additional tags to pick from.
    ///   - tagView: The tag view builder.
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.tags = tags
        self.additionalTags = additionalTags
        self.tagView = tagView
    }

    private let tags: Binding<[String]>
    private let additionalTags: [String]
    
    @ViewBuilder
    private let tagView: TagViewBuilder

    /// This type defines the tag view builder for the list.
    public typealias TagViewBuilder = (_ tag: String, _ hasTag: Bool) -> TagView

    public var body: some View {
        TagList(
            tags: allTags
        ) { tag in
            Button(action: { toggleTag(tag) }) {
                tagView(tag, hasTag(tag))
            }
            .withButtonStyle()
        }
    }
}

private extension View {

    func withButtonStyle() -> some View {
        self.buttonStyle(.plain)
    }
}

private extension TagEditList {

    var allTags: [String] {
        Array(Set(tags.wrappedValue + additionalTags)).sorted()
    }

    func addTag(_ tag: String) {
        if hasTag(tag) { return }
        tags.wrappedValue.append(tag)
    }

    func hasTag(_ tag: String) -> Bool {
        tags.wrappedValue.contains(tag)
    }

    func removeTag(_ tag: String) {
        guard hasTag(tag) else { return }
        tags.wrappedValue = tags.wrappedValue.filter { $0 != tag }
    }

    func toggleTag(_ tag: String) {
        if hasTag(tag) {
            removeTag(tag)
        } else {
            addTag(tag)
        }
    }
}

#Preview {

    struct Preview: View {

        @State var tags = ["tag-1"]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    TagEditList(
                        tags: $tags,
                        additionalTags: ["always-visible"]
                    ) { tag, isAdded in
                        Text(tag.slugified())
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(isAdded ? Color.green : Color.primary.opacity(0.1), in: .capsule)
                    }
                    .padding()
                }
            }
            .tagFlow(.horizontal)
        }
    }

    return Preview()
}
