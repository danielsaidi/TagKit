//
//  TagCapsule.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to render tags within a capsule shape.

 Note that the view will not slugify the provided tag, since
 this would require it to use the same slug configuration as
 was used to generate the tag. Instead, just provide it with
 an already slugified tag.
 */
public struct TagCapsule: View {

    /**
     Create a tag capsule.

     - Parameters:
       - tag: The tag to render.
       - style: The style to use.
     */
    public init(
        tag: String,
        style: TagCapsuleStyle
    ) {
        self.tag = tag
        self.style = style
    }

    private let tag: String
    private let style: TagCapsuleStyle

    public var body: some View {
        Text(tag)
            .padding(style.padding)
            .foregroundColor(style.foregroundColor)
            .background(style.backgroundColor)
            .clipShape(Capsule())
            .overlay(Capsule().strokeBorder(
                style.borderColor,
                lineWidth: style.borderWidth))
    }
}

struct TagCapsule_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            TagCapsule(tag: "standard-tag", style: .standard)
            TagCapsule(tag: "standard-selected-tag", style: .standardSelected)
        }
    }
}
