//
//  TagCapsuleStyle.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-09-07.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

#if !os(watchOS)
import SwiftUI

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public struct TagCapsuleStyle {
    
    /// Create a new tag capsule style.
    ///
    /// - Parameters:
    ///   - foregroundColor: The foreground color, by default `.primary`.
    ///   - backgroundColor: The background color, by default `.clear`.
    ///   - backgroundMaterial: The background material, by default `.ultraThin`.
    ///   - border: The border style, by default ``Border/standard``.
    ///   - shadow: The shadow style, by default ``Shadow/standard``.
    ///   - padding: The intrinsic padding to apply, by default a small padding.
    public init(
        foregroundColor: Color = .primary,
        backgroundColor: Color = .clear,
        backgroundMaterial: Material? = .ultraThin,
        border: Border = .standard,
        shadow: Shadow = .standard,
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
        self.border = border
        self.shadow = shadow
        self.padding = padding ?? defaultPadding
    }
    
    @available(*, deprecated, message: "Use the new borderStyle initializer instead.")
    public init(
        foregroundColor: Color = .primary,
        backgroundColor: Color = .clear,
        backgroundMaterial: Material? = .ultraThin,
        borderColor: Color = .clear,
        borderWidth: Double = 1,
        shadow: Shadow = .standard,
        padding: EdgeInsets? = nil
    ) {
        self.init(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            backgroundMaterial: backgroundMaterial,
            border: .init(
                color: borderColor,
                width: borderWidth
            ),
            shadow: shadow,
            padding: padding
        )
    }

    /// The foreground color.
    public var foregroundColor: Color

    /// The background color.
    public var backgroundColor: Color
    
    /// The background material.
    public var backgroundMaterial: Material?

    /// The border style.
    public var border: Border
    
    /// The shadow style.
    public var shadow: Shadow

    /// The padding to apply to the text.
    public var padding: EdgeInsets
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public extension TagCapsuleStyle {
    
    struct Border : Sendable {
        
        /// Create a new tag capsule border style.
        ///
        /// - Parameters:
        ///   - color: The border color, by default `.clear`.
        ///   - width: The border width, by default `1`.
        public init(
            color: Color = .clear,
            width: Double = 1
        ) {
            self.color = color
            self.width = width
        }

        /// The border color.
        public var color: Color

        /// The border width.
        public var width: Double
    }
    
    struct Shadow : Sendable{
        
        /// Create a new tag capsule shadow style.
        ///
        /// - Parameters:
        ///   - color: The shadow color, by default `.clear`.
        ///   - radius: The shadow radius, by default `0`.
        ///   - offsetX: The x offset, by default `0`.
        ///   - offsetY: The y offset, by default `1`.
        public init(
            color: Color = .clear,
            radius: Double = 0,
            offsetX: Double = 0,
            offsetY: Double = 1
        ) {
            self.color = color
            self.radius = radius
            self.offsetX = offsetX
            self.offsetY = offsetY
        }

        /// The shadow color.
        public var color: Color

        /// The shadow radius.
        public var radius: Double
        
        /// The x offset.
        public var offsetX: Double

        /// The y offset.
        public var offsetY: Double
    }

    /// The standard style.
    static var standard: Self {
        .init()
    }

    /// The standard, selected style.
    static var standardSelected: Self {
        .init(
            backgroundMaterial: .regular,
            border: .standardSelected,
            shadow: .standardSelected
        )
    }
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public extension TagCapsuleStyle.Shadow {

    /// The standard shadow style.
    static var standard: Self {
        .init()
    }

    /// The standard, selected shadow style.
    static var standardSelected: Self {
        .init(
            color: .primary.opacity(0.5),
            radius: 0
        )
    }
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public extension TagCapsuleStyle.Border {

    /// The standard border style.
    static var standard: Self {
        .init()
    }

    /// The standard, selected border style.
    static var standardSelected: Self {
        .init()
    }
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public extension View {

    /// Apply a ``TagCapsule`` style to the view hierarchy.
    func tagCapsuleStyle(
        _ style: TagCapsuleStyle
    ) -> some View {
        self.environment(\.tagCapsuleStyle, style)
    }
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
private extension TagCapsuleStyle {

    struct Key: EnvironmentKey {

        public static var defaultValue: TagCapsuleStyle { .standard }
    }
}

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
public extension EnvironmentValues {

    /// This value can bind to a line spacing picker config.
    var tagCapsuleStyle: TagCapsuleStyle {
        get { self [TagCapsuleStyle.Key.self] }
        set { self [TagCapsuleStyle.Key.self] = newValue }
    }
}
#endif
