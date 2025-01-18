//
//  TagList.swift
//  TagKit
//
//  Based on https://github.com/globulus/swiftui-flow-layout
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI


/// This enum specifies supported tag list container types.
public enum TagListContainer {

    case scrollView, vstack
}

/**
 This view lists tags in a leading to trailing flow.

 The view takes a list of tags and use the provided tag view
 builder to render a view for each tag. This gives you a lot
 of flexibility, since you can use any view you want.

 Note that the list will not slugify the provided tags since
 this would require it to use the same slug configuration as
 was used to generate the tags. Just provide it with already
 slugified tags.

 You must specify a container type, since the list has to be
 rendered differently depending on if it's in a `ScrollView`
 or a `VerticalStack`.
 
 You will often want to add a ``onTapGesture(count:perform:)`` inside the `TapViewBuilder`.
 */
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
        container: TagListContainer = .scrollView,
        horizontalSpacing: CGFloat = 5,
        verticalSpacing: CGFloat = 5,
        @ViewBuilder tagView: @escaping TagViewBuilder
        
    ) {
        self.tags = tags
        self.container = container
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.tagView = tagView
        let initialHeight: CGFloat = container == .scrollView ? .zero : .infinity
        _viewSize = State(initialValue: CGSize(width: 0, height: initialHeight))
    }

    private let tags: [String]
    private let container: TagListContainer
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    @ViewBuilder
    private let tagView: TagViewBuilder

    /// This type defines the tag view builder for the list.
    public typealias TagViewBuilder = (_ tag: String) -> TagView
    @State private var viewSize: CGSize


    public var body: some View {
        if container == .scrollView {
            content.frame(height: viewSize.height)
        } else {
            content.frame(maxHeight: viewSize.height)
        }
    }
}

@MainActor
private extension TagList {
    var content: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero
        let itemCount = tags.count
        return ZStack(alignment: .topLeading) {
            HeightReader(height: $viewSize)
            ForEach(Array(tags.enumerated()), id: \.offset) { index, item in
                tagView(item)
                    .padding([.horizontal], horizontalSpacing)
                    .padding([.vertical], verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > viewSize.width {
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
                    .background(.clear)
            }
        }

    }
}

#Preview {

    let tags = [
        "A long text here", "Another long text here",
        "A", "bunch", "of", "short", "texts", "in", "a", "row",
        "And then a very very very long long long long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long long long one",
        "and", "then", "some", "more", "short", "ones"
    ]

    return ScrollView {
        TagList(tags: tags) {  tag in
            Text(tag)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding()
    }
}
