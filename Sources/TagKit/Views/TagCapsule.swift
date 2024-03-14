//
//  TagCapsule.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to render tags within a capsule shape.

 The view will not slugify the provided tag string, only use
 the content you provide it with.
 */
public struct TagCapsule: View {

    /// Create a tag capsule.
    ///
    /// - Parameters:
    ///   - tag: The tag to render.
    public init(
        _ tag: String
    ) {
        self.tag = tag
    }

    private let tag: String
    
    @Environment(\.tagCapsuleStyle)
    private var style: TagCapsuleStyle

    public var body: some View {
        Text(tag)
            .padding(style.padding)
            .foregroundColor(style.foregroundColor)
            .background(Capsule()
                .strokeBorder(
                    style.borderColor,
                    lineWidth: style.borderWidth
                )
            )
            .materialCapsuleBackground(with: style.backgroundMaterial)
            .background(Capsule().fill(style.backgroundColor))
            
    }
}

private extension View {
    
    @ViewBuilder
    func materialCapsuleBackground(
        with material: Material?
    ) -> some View {
        if let material {
            self.background(Capsule().fill(material))
        } else {
            self
        }
    }
}

#Preview {

    VStack {
        TagCapsule("standard-tag")
        TagCapsule("standard-selected-tag")
            .font(.body.bold())
            .tagCapsuleStyle(.standardSelected)
        TagCapsule("spider-man")
            .tagCapsuleStyle(.init(
                foregroundColor: .black,
                backgroundColor: .red,
                borderColor: .blue,
                borderWidth: 4,
                padding: .init(
                    top: 10,
                    leading: 20,
                    bottom: 12,
                    trailing: 20
                )
            ))
    }
    .preferredColorScheme(.dark)
}
