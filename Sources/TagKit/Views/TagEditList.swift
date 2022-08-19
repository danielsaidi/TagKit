//
//  TagEditList.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view lists tags in a leading to trailing flow and lets
 you tap tags to add and remove them from a provided binding.

 The view takes a list of tags and use the provided tag view
 builder to render a view for each tag. This gives you a lot
 of flexibility, since you can use any view you want.

 Note that the list will not slugify the provided tags since
 this would require it to use the same slug configuration as
 was used to generate the tags. Just provide it with already
 slugified tags.

 Note that tags that only exist in `tags` will be removed if
 they are toggled off. To make them stick around, just make
 sure to add them to `additionalTags` as well.

 You must specify a container type, since the list has to be
 rendered differently depending on if it's in a `ScrollView`
 or a `VerticalStack`.
 */
public struct TagEditList<TagView: View>: View {

    /**
     Create a tag edit list.

     The list will list all tags in the provided tag binding,
     as well as all tags in the additional provided tag list.
     This lets you provide a set of tags to pick from.

     - Parameters:
       - tags: The items to render in the layout.
       - additionalTags: Additional tags to pick from.
       - container: The container type, by default `.scrollView`.
       - horizontalSpacing: The horizontal spacing between items.
       - verticalSpacing: The vertical spacing between items.
       - tagView: The tag view builder.
     */
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

    /**
     This type defines the tag view builder for the list.
     */
    public typealias TagViewBuilder = (_ tag: String, _ hasTag: Bool) -> TagView


    @State
    private var totalHeight: CGFloat

    public var body: some View {
        TagList(
            tags: allTags,
            container: container,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing) { tag in
                Button(action: { toggleTag(tag) }) {
                    tagView(tag, hasTag(tag))
                }.withButtonStyle()
            }
    }
}

private extension View {

    func withButtonStyle() -> some View {
        #if os(watchOS)
        self
        #else
        self.buttonStyle(.borderless)
        #endif
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

#if os(iOS)
struct TagEditList_Previews: PreviewProvider {

    struct Preview: View {

        @State
        var newTag = ""

        @State
        var tags = ["foo", "bar", "baz"]

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        TagTextField(
                            text: $newTag,
                            placeholder: "Add new tag"
                        )
                        .textFieldStyle(.roundedBorder)
                        .overlay(addButton, alignment: .trailing)

                        TagEditList(
                            tags: $tags,
                            additionalTags: ["foo", "bar", "baz", "tag-1", "tag-2", "tag-3", "tag-4", "tag-5"]
                        ) { tag, hasTag in
                            TagCapsule(tag: tag, style: hasTag ? .standardSelected : .standard)
                        }
                    }.padding()
                }
                .font(.title)
                .navigationBarTitle("TagKit")
            }
        }

        private var addButton: some View {
            Button("Add") {
                addTag(tag: newTag)
            }.padding(.horizontal, 10)
        }

        private func addTag(tag: String) {
            tags.append(tag.slugified())
            newTag = ""
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
