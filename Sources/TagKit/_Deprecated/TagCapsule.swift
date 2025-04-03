//
//  TagCapsule.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
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
            .materialCapsuleBackground(with: style.backgroundMaterial)
            .background(Capsule().fill(style.backgroundColor))
            .padding(style.border.width)
            .background(Capsule()
                .strokeBorder(
                    style.border.color,
                    lineWidth: style.border.width
                )
            )
            .compositingGroup()
            .shadow(
                color: style.shadow.color,
                radius: style.shadow.radius,
                x: style.shadow.offsetX,
                y: style.shadow.offsetY
            )
            
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

@available(*, deprecated, message: "Just use a regular Text element and style it as you wish.")
private extension TagCapsuleStyle {
    
    static var spiderman: Self {
        .init(
            foregroundColor: .black,
            backgroundColor: .red,
            backgroundMaterial: .thin,
            border: .init(
                color: .blue,
                width: 4
            ),
            padding: .init(
                top: 10,
                leading: 20,
                bottom: 12,
                trailing: 20
            )
        )
    }
    
    static var spidermanSelected: Self {
        var style = Self.spiderman
        style.backgroundMaterial = .none
        style.shadow = .standardSelected
        return style
    }
}
