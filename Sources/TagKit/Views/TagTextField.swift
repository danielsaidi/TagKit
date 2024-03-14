//
//  TagTextField.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2021-04-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This text field will automatically slugify any text that is
 entered into it.

 This text field will also make it harder to type characters
 that are not in the configuration's allowed character set.
 */
public struct TagTextField: View {

    /// Create a new tag text field.
    ///
    /// - Parameters:
    ///   - text: The text binding.
    ///   - placeholder: The text field placeholder, by default empty.
    ///   - configuration: The slug configuration to use, by default ``SlugConfiguration/standard``.
    public init(
        text: Binding<String>,
        placeholder: String = "",
        configuration: SlugConfiguration = .standard
    ) {
        self.text = Binding<String>(
            get: { text.wrappedValue.slugified() },
            set: { text.wrappedValue = $0.slugified() }
        )
        self.placeholder = placeholder
        self.configuration = configuration
    }
    
    private let text: Binding<String>
    private let placeholder: String
    private let configuration: SlugConfiguration
    
    public var body: some View {
        TextField(placeholder, text: text)
            .textCase(.lowercase)
            .withoutCapitalization()
    }
}

private extension View {
    
    @ViewBuilder
    func withoutCapitalization() -> some View {
        #if os(iOS)
        self.autocapitalization(.none)
        #else
        self
        #endif
    }
}

#Preview {
    
    struct Preview: View {
    
        @State var text = ""
        
        var body: some View {
            TagTextField(text: $text, placeholder: "Enter tag")
                #if os(iOS)
                .textFieldStyle(.roundedBorder)
                #endif
                .padding()
        }
    }
    
    return Preview()
}
