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
            .padding(style.borderWidth)
            .background(Capsule()
                .strokeBorder(
                    style.borderColor,
                    lineWidth: style.borderWidth
                )
            )
            .compositingGroup()
            
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
                    TagCapsule("material")
                        .tagCapsuleStyle(.standardMaterial)
                    TagCapsule("material-selected")
                        .tagCapsuleStyle(.standardSelectedMaterial)
                }
                
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
                    .shadow(radius: 0, y: 2)
            }
            .padding(.top, 250)
        }
    }
}
