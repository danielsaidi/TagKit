//
//  TagEditList.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view lists tags in a leading to trailing flow and lets
 you tap tags to add and remove them from a provided binding.

 The view takes a list of tags and use a tag view builder to
 render a view for each tag. You can use any custom tag view,
 for instance a ``TagCapsule``.
 
 The view can take a list of additional tags. Tho avoid that
 tags disappear from the list when you toggle them off. Make
 sure to use the `additionalTags` parameter to specify which
 tags you always want to show in the list.

 You must specify a `container`, since this list is rendered
 differently depending on if it's added to a `ScrollView` or
 a `VerticalStack`.
 */
public struct TagEditList<TagView: View>: View {

    /// Create a tag edit list.
    ///
    /// - Parameters:
    ///   - tags: The items to render in the layout.
    ///   - additionalTags: Additional tags to pick from.
    ///   - container: The container type, by default `.scrollView`.
    ///   - horizontalSpacing: The horizontal spacing between items.
    ///   - verticalSpacing: The vertical spacing between items.
    ///   - tagView: The tag view builder.
    public init(
        tags: Binding<[String]>,
        additionalTags: [String],
        container: TagListContainer = .scrollView,
        horizontalSpacing: CGFloat = 5,
        verticalSpacing: CGFloat = 5,
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.tags = tags
        self.additionalTags = additionalTags
        self.container = container
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.tagView = tagView
        let initialHeight: CGFloat = container == .scrollView ? .zero : .infinity
        _totalHeight = State(initialValue: initialHeight)
    }

    private let tags: Binding<[String]>
    private let additionalTags: [String]
    private let container: TagListContainer
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    @ViewBuilder
    private let tagView: TagViewBuilder

    /// This type defines the tag view builder for the list.
    public typealias TagViewBuilder = (_ tag: String, _ hasTag: Bool) -> TagView

    @State
    private var totalHeight: CGFloat

    public var body: some View {
        TagList(
            tags: allTags,
            container: container,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing
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

        @State
        var newTag = ""

        @State
        var tags = ["foo", "bar", "baz"]

        @State
        var added: [String] = []

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        TagTextField(
                            text: $newTag,
                            placeholder: "Add new tag"
                        )
                        #if os(iOS)
                        .textFieldStyle(.roundedBorder)
                        #endif
                        .overlay(addButton, alignment: .trailing)

                        TagEditList(
                            tags: $tags,
                            additionalTags: ["foo", "bar", "baz", "tag-1", "tag-2", "tag-3", "tag-4", "tag-5"] + added
                        ) { tag, hasTag in
                            TagCapsule(tag)
                                .tagCapsuleStyle(hasTag ? .standardSelected : .standard)
                        }
                    }
                    .padding()
                }
                .navigationTitle("TagKit")
            }
        }

        private var addButton: some View {
            Button("Add") {
                addTag(tag: newTag)
            }
            .padding(.horizontal, 10)
        }

        private func addTag(tag: String) {
            let slug = tag.slugified()
            tags.append(slug)
            added.append(slug)
            newTag = ""
        }
    }

    return Preview()
}
