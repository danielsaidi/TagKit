//
//  TagCapsuleStyle.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-09-07.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style ``TagCapsule`` views. It
/// lets you define visual styles like colors and padding.
///
/// There is a boring ``TagCapsuleStyle/standard`` style, as
/// well as the even worse``TagCapsuleStyle/standardSelected``
/// style. There are also some material-based styles such as
/// ``TagCapsuleStyle/standardMaterial``.
public struct TagCapsuleStyle {

    /// Create a new tag capsule style.
    ///
    /// - Parameters:
    ///   - foregroundColor: The foreground color to use, by default `.black`.
    ///   - backgroundColor: The background color to use, by default `.gray`.
    ///   - backgroundMaterial: The background material to use, by default `.blue`.
    ///   - borderColor: The border color to use, by default `.clear`.
    ///   - borderWidth: The border width to use, by default `1`.
    ///   - padding: The intrinsic padding to apply, by default a small padding.
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

    /// The standard style.
    static var standard: TagCapsuleStyle { .init() }

    /// The standard, selected style.
    static var standardSelected: TagCapsuleStyle {
        .init(
            foregroundColor: .white,
            backgroundColor: .black,
            borderColor: .white
        )
    }
    
    /// A standard material-based style.
    static var standardMaterial: TagCapsuleStyle {
        .init(
            foregroundColor: .primary,
            backgroundColor: .clear,
            backgroundMaterial: .ultraThin
        )
    }
    
    /// A standard, selected material-based style.
    static var standardMaterialSelected: TagCapsuleStyle {
        .init(
            foregroundColor: .primary,
            backgroundColor: .clear,
            backgroundMaterial: .regular
        )
    }
}

public extension TagCapsuleStyle {
    
    @available(*, deprecated, renamed: "standardMaterialSelected")
    static var standardSelectedMaterial: TagCapsuleStyle {
        .standardMaterialSelected
    }
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

        public static var defaultValue: TagCapsuleStyle { .standard }
    }
}

public extension EnvironmentValues {

    /// This value can bind to a line spacing picker config.
    var tagCapsuleStyle: TagCapsuleStyle {
        get { self [TagCapsuleStyle.Key.self] }
        set { self [TagCapsuleStyle.Key.self] = newValue }
    }
}
