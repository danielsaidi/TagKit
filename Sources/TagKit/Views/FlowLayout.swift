//
//  FlowLayout.swift
//  WallyKit
//
//  Based on https://github.com/globulus/swiftui-flow-layout
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view lists data in a leading to trailing flow.

 The view will break to a new line whenever the view doesn't
 fit on the current line.

 You must specify a container type, since the view has to be
 rendered differently depending on if it's in a `ScrollView`
 or a `VerticalStack`.

 The view is internal and kept for reference, if we will use
 it on other ways in the future.
 */
struct FlowLayout<ItemType, ItemView: View>: View {

    /**
     Create a flow layout.

     - Parameters:
       - container: The container type.
       - items: The items to render in the layout.
       - horizontalSpacing: The horizontal spacing between items.
       - verticalSpacing: The vertical spacing between items.
       - itemView: The item view builder.
     */
    init(
        container: ContainerType,
        items: [ItemType],
        horizontalSpacing: CGFloat = 5,
        verticalSpacing: CGFloat = 5,
        @ViewBuilder itemView: @escaping (ItemType) -> ItemView
    ) {
        self.container = container
        self.items = items
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.itemView = itemView
        let initialHeight: CGFloat = container == .scrollView ? .zero : .infinity
        _totalHeight = State(initialValue: initialHeight)
    }

    private let container: ContainerType
    private let items: [ItemType]
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    @ViewBuilder
    let itemView: (ItemType) -> ItemView

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

private extension FlowLayout {

    var content: some View {
        GeometryReader { geometry in
            content(in: geometry)
        }
    }

    func content(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero
        let itemCount = items.count
        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
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

struct FlowLayout_Previews: PreviewProvider {

    static var previews: some View {
        FlowLayout(
            container: .scrollView,
            items: ["A long text here", "Another long text here",
                    "A", "bunch", "of", "short", "texts", "in", "a", "row",
                    "And then a very very very long long long long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long long long one",
                    "and", "then", "some", "more", "short", "ones"
                   ]
        ) {
            Text($0)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4)
                    .border(Color.gray)
                    .foregroundColor(Color.gray))
        }.padding()
    }
}
