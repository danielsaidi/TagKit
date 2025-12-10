//
//  Slugs.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

// MARK: - Protocol

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


// MARK: - Configuration

/// This configuration defines how ``Slugifiable`` types are
/// slugified.
///
/// The standard configuration allows `a-z0-9`, and will for
/// instance slugify `Hello, world!` into `hello-world`.
public struct SlugConfiguration {

    /// Create a new slug configurator.
    ///
    /// - Parameters:
    ///   - separator: The separator to use, by default `-`.
    ///   - allowedCharacters: The characters to allow, by default `a-z0-9`.
    public init(
        separator: String = "-",
        allowedCharacters: String = "abcdefghijklmnopqrstuvwxyz0123456789"
    ) {
        let chars = allowedCharacters + separator
        self.separator = separator
        self.allowedCharacters = chars
        let allowedSet = NSCharacterSet(charactersIn: chars)
        self.allowedCharacterSet = allowedSet
        self.notAllowedCharacterSet = allowedSet.inverted
    }

    /// The separator to use in the slugified string.
    public let separator: String

    /// The characters to allow in the slugified string.
    public let allowedCharacters: String
    
    /// The characters to allow in the slugified string.
    public let allowedCharacterSet: NSCharacterSet
    
    /// The characters to not allow in the slugified string.
    public let notAllowedCharacterSet: CharacterSet
}

public extension SlugConfiguration {

    /// A standard slug configuration, with `-` as separator
    /// and `a-zA-Z0-9` as the allowed characters.
    static var standard: SlugConfiguration { .init() }
}
