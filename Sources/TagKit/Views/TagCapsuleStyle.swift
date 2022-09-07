//
//  TagCapsuleStyle.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-09-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

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

struct TagCapsuleStyle_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            TagCapsule(tag: "standard-tag", style: .standard)
            TagCapsule(tag: "standard-selected-tag", style: .standardSelected)
        }
    }
}
