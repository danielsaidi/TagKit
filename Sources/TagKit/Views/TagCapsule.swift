//
//  TagCapsule.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-19.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to render tags in a capsule shape.
///
/// This view will not slugify the provided tag string, only
/// use the content you provide.
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

#Preview {
    
    ZStack {
        LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        ScrollView {
            VStack {
                HStack {
                    TagCapsule("standard")
                        .tagCapsuleStyle(.standard)
                    TagCapsule("standard-selected")
                        .tagCapsuleStyle(.standardSelected)
                }
                HStack {
                    TagCapsule("spider-man")
                        .tagCapsuleStyle(.spiderman)
                    TagCapsule("spider-man-selected")
                        .tagCapsuleStyle(.spidermanSelected)
                }
            }
            .padding(.top, 250)
        }
    }
}

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
