//
//  File.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// slugified into a slug representation.
public protocol Slugifiable {

    /// The string that should represent the value as a slug.
    var slugValue: String { get }
}

public extension Slugifiable {

    /// Create a slugified version of the type.
    ///
    /// - Parameters:
    ///   - config: The config to use, by default ``SlugConfiguration/standard``.
    func slugified(
        with config: SlugConfiguration = .standard
    ) -> String {
        slugValue
            .lowercased()
            .components(separatedBy: config.notAllowedCharacterSet)
            .filter { !$0.isEmpty }
            .joined(separator: config.separator)
    }
}


// MARK: - String

extension String: Slugifiable {}

public extension String {

    var slugValue: String { self }
}
