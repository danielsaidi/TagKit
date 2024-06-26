//
//  SlugConfiguration.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This configuration defines how ``Slugifiable`` types are
/// slugified.
///
/// Use the ``SlugConfiguration/standard`` configuration for
/// the default behavior, which limits the slugified strings
/// to `a-z` and `1-9`, using `-` as separator.
public struct SlugConfiguration {

    /// Create a new slug configurator.
    ///
    /// - Parameters:
    ///   - separator: The separator to use in the slugified string, by default `-`.
    ///   - allowedCharacters: The characters to allow in the slugified string, by default alphanumerical characters and `-`.
    public init(
        separator: String = "-",
        allowedCharacters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    ) {
        let chars = allowedCharacters + separator
        self.separator = separator
        self.allowedCharacters = chars
        self.allowedCharacterSet = NSCharacterSet(charactersIn: chars)
    }

    /// The separator to use in the slugified string.
    public let separator: String

    /// The characters to allow in the slugified string.
    public let allowedCharacters: String

    /// The character set to allow in the slugified string.
    public let allowedCharacterSet: NSCharacterSet
}

public extension SlugConfiguration {

    /// A standard slug configuration, that allows `a-z` and
    /// `1-9` and uses `-` as the component separator.
    static var standard: SlugConfiguration { .init() }
}
