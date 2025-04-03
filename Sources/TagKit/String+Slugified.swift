//
//  String+Slug.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /// Create a slugified version of the string.
    ///
    /// - Parameters:
    ///   - configuration: The configuration to use, by default ``SlugConfiguration/standard``.
    func slugified(
        with configuration: SlugConfiguration = .standard
    ) -> String {
        lowercased()
            .components(separatedBy: configuration.notAllowedCharacterSet)
            .filter { !$0.isEmpty }
            .joined(separator: configuration.separator)
    }
}
