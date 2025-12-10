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

/// This view can be used to list a collection of tags, with
/// a custom `tagView` builder.
///
/// You can apply a ``SwiftUICore/View/tagFlow(_:)`` to this
/// view, to make tags flow horizontally or vertically.
///
/// > Note: The view doesn't slugify the strings you provide,
/// so make to do so beforehand.
public struct TagList<TagView: View>: View {

    /// Create a tag list.
    ///
    /// - Parameters:
    ///   - tags: The items to render in the layout.
    ///   - tagView: The item view builder.
    public init(
        tags: [String],
        @ViewBuilder tagView: @escaping TagViewBuilder
    ) {
        self.tags = tags
        self.tagView = tagView
    }

    private let tags: [String]

    @ViewBuilder private let tagView: TagViewBuilder

    @Environment(\.tagFlow) var flow

    /// This type defines the tag view builder for the list.
    public typealias TagViewBuilder = (_ tag: String) -> TagView

    public var body: some View {
        switch flow {
        case .automatic, .plain:
            bodyContent()
        case .horizontal(let config):
            HFlow(
                horizontalAlignment: config.horizontalAlignment,
                verticalAlignment: config.verticalAlignment,
                horizontalSpacing: config.horizontalSpacing,
                verticalSpacing: config.verticalSpacing,
                justified: config.justified,
                distributeItemsEvenly: config.distributeItemsEvenly,
                content: bodyContent
            )
        case .vertical(let config):
            VFlow(
                horizontalAlignment: config.horizontalAlignment,
                verticalAlignment: config.verticalAlignment,
                horizontalSpacing: config.horizontalSpacing,
                verticalSpacing: config.verticalSpacing,
                justified: config.justified,
                distributeItemsEvenly: config.distributeItemsEvenly,
                content: bodyContent
            )
        }
    }
}

private extension TagList {

    func bodyContent() -> some View {
        ForEach(Array(tags.enumerated()), id: \.offset) {
            tagView($0.element)
        }
    }
}

@MainActor
private var previewContent: some View {
    TagList(tags: [
        "A long tag here",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags",
        "Another long tag here",
        "A", "bunch", "of", "short", "tags"
    ]) { tag in
        Text(tag.slugified())
            .tagCapsule(background: .green, foreground: .black)
    }
    .padding()
}

#Preview("Horizontal") {

    ScrollView(.vertical) {
        previewContent
    }
    .tagFlow(.horizontal)
}

#Preview("Vertical") {

    ScrollView(.horizontal) {
        previewContent
    }
    .tagFlow(.vertical)
}

#Preview("Automatic") {

    ScrollView {
        previewContent
    }
    .tagFlow(.automatic)
}
