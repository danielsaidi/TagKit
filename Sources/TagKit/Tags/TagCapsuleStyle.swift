//
//  TagCapsuleStyle.swift
//  TagKit
//
//  Created by Daniel Saidi on 2025-12-10.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style a tag capsule.
///
/// It can be applied with ``SwiftUICore/View/tagCapsule(style:)``.
public struct TagCapsuleStyle: Sendable {

    /// Create a custom tag capsule style.
    public init(
        background: Color,
        foreground: Color,
        horizontalPadding: Double? = nil,
        verticalPadding: Double? = nil
    ) {
        self.background = background
        self.foreground = foreground
        self.horizontalPadding = horizontalPadding ?? 10
        self.verticalPadding = verticalPadding ?? 3
    }

    public let background: Color
    public let foreground: Color
    public let horizontalPadding: Double
    public let verticalPadding: Double
}

public extension View {

    /// Style the view as a tag capsule.
    func tagCapsule(
        style: TagCapsuleStyle
    ) -> some View {
        self.foregroundStyle(style.foreground)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background(style.background, in: .capsule)
    }

    /// Style the view as a tag capsule.
    func tagCapsule(
        background: Color,
        foreground: Color,
        horizontalPadding: Double? = nil,
        verticalPadding: Double? = nil
    ) -> some View {
        self.tagCapsule(
            style: .init(
                background: background,
                foreground: foreground,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding
            )
        )
    }

    /// Style the view as a tag capsule.
    func tagCapsule(
        _ background: Color,
        _ foreground: Color,
        horizontalPadding: Double? = nil,
        verticalPadding: Double? = nil
    ) -> some View {
        self.tagCapsule(
            background: background,
            foreground: foreground,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding
        )
    }
}

#Preview {
    Text("Hello, world".slugified())
        .tagCapsule(.red, .yellow)
}
