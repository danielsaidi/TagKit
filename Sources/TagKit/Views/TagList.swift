//
//  TagList.swift
//  WallyKit
//
//  Based on https://github.com/globulus/swiftui-flow-layout
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view lists tags in a leading to trailing flow.

 The view takes a list of tags and use the provided tag view
 builder to render a view for each tag. This gives you a lot
 of flexibility, since you can use any view you want.

 Tags will break to new lines whenever they don't fit on the
 current line.

 You must specify a container type, since the list has to be
 rendered differently depending on if it's in a `ScrollView`
 or a `VerticalStack`.
 */
struct TagList<ItemView: View>: View {

    /**
     Create a tag list.

     The list will not slugify the provided tags, since this
     would require it to use the same slug config as the tag
     collection was created with, which can lead to bugs. Do
     make sure to only provide this view with slugified tags.

     - Parameters:
       - tags: The items to render in the layout.
       - configuration: The slug configuration to use, by default ``SlugConfiguration/standard``.
       - container: The container type, by default `.scrollView`.
       - horizontalSpacing: The horizontal spacing between items.
       - verticalSpacing: The vertical spacing between items.
       - itemView: The item view builder.
     */
    init(
        tags: [String],
        configuration: SlugConfiguration = .standard,
        container: ContainerType = .scrollView,
        horizontalSpacing: CGFloat = 5,
        verticalSpacing: CGFloat = 5,
        @ViewBuilder itemView: @escaping (String) -> ItemView
    ) {
        self.tags = tags
        self.container = container
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.itemView = itemView
        let initialHeight: CGFloat = container == .scrollView ? .zero : .infinity
        _totalHeight = State(initialValue: initialHeight)
    }

    private let tags: [String]
    private let container: ContainerType
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    @ViewBuilder
    let itemView: (String) -> ItemView

    /**
     This enum specifies all supported container types.
     */
    public enum ContainerType {

        case scrollView, vstack
    }

    @State
    private var totalHeight: CGFloat

    var body: some View {
        if container == .scrollView {
            content.frame(height: totalHeight)
        } else {
            content.frame(maxHeight: totalHeight)
        }
    }
}

private extension TagList {

    var content: some View {
        GeometryReader { geometry in
            content(in: geometry)
        }
    }

    func content(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero
        let itemCount = tags.count
        return ZStack(alignment: .topLeading) {
            ForEach(Array(tags.enumerated()), id: \.offset) { index, item in
                itemView(item)
                    .padding([.horizontal], horizontalSpacing)
                    .padding([.vertical], verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
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
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return .clear
        }
    }
}

struct TagList_Previews: PreviewProvider {

    static var tags = [
        "A long text here", "Another long text here",
        "A", "bunch", "of", "short", "texts", "in", "a", "row",
        "And then a very very very long long long long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long long long one",
        "and", "then", "some", "more", "short", "ones"
    ]

    static var previews: some View {
        ScrollView {
            TagList(tags: tags) {
                Text($0)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }.padding()
        }
    }
}
