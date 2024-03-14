//
//  TagCapsuleStyle.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-09-07.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used to style ``TagCapsule`` views.

 The style lets you define colors and padding. For all other
 styles, use native view modifiers.

 TagKit comes with a boring ``TagCapsuleStyle/standard`` and
 an even worse``TagCapsuleStyle/standardSelected`` style. Do
 design your own styles to make your tags pop!
 */
public struct TagCapsuleStyle {

    /**
     Create a new tag capsule style.

     - Parameters:
       - foregroundColor: The foreground color to use, by default `.black`.
       - backgroundColor: The background color to use, by default `.gray`.
       - backgroundMaterial: The background material to use, by default `.blue`.
       - borderColor: The border color to use, by default `.clear`.
       - borderWidth: The border width to use, by default `1`.
       - padding: The intrinsic padding to apply, by default a small padding.
     */
    public init(
        foregroundColor: Color = .black,
        backgroundColor: Color = .gray,
        backgroundMaterial: Material? = nil,
        borderColor: Color = .clear,
        borderWidth: Double = 1,
        padding: EdgeInsets? = nil
    ) {
        var defaultPadding: EdgeInsets
        #if os(tvOS)
        defaultPadding = .init(top: 12, leading: 20, bottom: 14, trailing: 20)
        #else
        defaultPadding = .init(top: 5, leading: 10, bottom: 7, trailing: 10)
        #endif
        
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.backgroundMaterial = backgroundMaterial
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.padding = padding ?? defaultPadding
    }

    /// The foreground color to use.
    public var foregroundColor: Color

    /// The background color to use.
    public var backgroundColor: Color
    
    /// The background material to use.
    public var backgroundMaterial: Material?

    /// The border color to use.
    public var borderColor: Color

    /// The border width to use.
    public var borderWidth: Double

    /// The padding to apply to the text.
    public var padding: EdgeInsets
}

public extension TagCapsuleStyle {

    /// The standard tag capsule style.
    ///
    /// You can set this style to change the global default.
    static var standard = TagCapsuleStyle()

    /// The standard, selected tag capsule style.
    ///
    /// You can set this style to change the global default.
    static var standardSelected = TagCapsuleStyle(
        foregroundColor: .white,
        backgroundColor: .black,
        borderColor: .white
    )
}

public extension View {

    /// Apply a ``TagCapsule`` style to the view hierarchy.
    func tagCapsuleStyle(
        _ style: TagCapsuleStyle
    ) -> some View {
        self.environment(\.tagCapsuleStyle, style)
    }
}

private extension TagCapsuleStyle {

    struct Key: EnvironmentKey {

        public static var defaultValue: TagCapsuleStyle = .standard
    }
}

public extension EnvironmentValues {

    /// This value can bind to a line spacing picker config.
    var tagCapsuleStyle: TagCapsuleStyle {
        get { self [TagCapsuleStyle.Key.self] }
        set { self [TagCapsuleStyle.Key.self] = newValue }
    }
}


#Preview {

    VStack {
        TagCapsule("standard-tag")
        TagCapsule("standard-selected-tag")
            .font(.body.bold())
            .tagCapsuleStyle(.standardSelected)
            .shadow(radius: 0, x: 0, y: 2)
        TagCapsule("custom")
            .tagCapsuleStyle(.init(
                backgroundColor: .clear,
                backgroundMaterial: .thick
            ))
    }
    .background {
        LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
    }
}
