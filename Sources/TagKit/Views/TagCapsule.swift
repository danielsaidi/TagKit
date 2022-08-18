//
//  TagCapsule.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
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
            .background(Capsule().strokeBorder(
                style.borderColor,
                lineWidth: style.borderWidth))
    }
}

/**
 This style can be used to style ``TagCapsule`` views.

 The style lets you define colors and padding. For all other
 styles, use native view modifiers.

 TagKit comes with a boring ``TagCapsuleStyle/standard`` and
 an even worse``TagCapsuleStyle/standardSelected`` style. Do
 make sure to define your own styles to make your tags pop!
 */
public struct TagCapsuleStyle {

    /**
     Create a new tag capsule style.

     - Parameters:
       - foregroundColor: The foreground color to use, by default `.primary`.
       - backgroundColor: The foreground color to use, by default `.blue`.
       - borderColor: The border color to use, by default `.clear`.
       - borderWidth: The border width to use, by default `1`.
       - padding: The padding to apply to the text.
     */
    public init(
        foregroundColor: Color = .primary,
        backgroundColor: Color = .blue,
        borderColor: Color = .clear,
        borderWidth: Double = 1,
        padding: EdgeInsets = .init(top: 5, leading: 10, bottom: 7, trailing: 10)
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.padding = padding
    }

    /**
     The foreground color to use, by default `.primary`.
     */
    public var foregroundColor: Color

    /**
     The foreground color to use, by default `.blue`.
     */
    public var backgroundColor: Color

    /**
     The border color to use, by default `.clear`.
     */
    public var borderColor: Color

    /**
     The border width to use, by default `1`.
     */
    public var borderWidth: Double

    /**
     The padding to apply to the text.
     */
    public var padding: EdgeInsets
}

public extension TagCapsuleStyle {

    /**
     Get the standard selected tag badge style.

     You can override this style to change the default style.
     */
    static var standard = TagCapsuleStyle(
        foregroundColor: .white,
        backgroundColor: .blue,
        borderColor: .clear)

    /**
     Get the standard tag badge style.

     You can override this style to change the default style.
     */
    static var standardSelected = TagCapsuleStyle(
        foregroundColor: .white,
        backgroundColor: .green,
        borderColor: .clear)
}

struct TagCapsule_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            TagCapsule(tag: "standard-tag", style: .standard)
            TagCapsule(tag: "standard-selected-tag", style: .standardSelected)
        }
    }
}
