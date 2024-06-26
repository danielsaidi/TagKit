//
//  Slugifiable.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol describes a slugifiable type, which can be
/// represented as a slugified string.
///
/// Slugified strings are for instance used in urls and tags,
/// where a text is represented by removing unsupported text
/// components. The standard format can be customized with a
/// custom ``SlugConfiguration``.
///
/// By default, `Hello, world!` is slugified to `hello-world`.
///
/// This protocol is automatically implemented by `String`.
public protocol Slugifiable {

    /// The value used to create a slugified representation.
    var slugifiableValue: String { get }
}

public extension Slugifiable {

    /// Convert the slugifiable value to a slugified string.
    ///
    /// With the default configuration, `Hello, world!` will
    /// be slugified to `hello-world`.
    ///
    /// - Parameters:
    ///   - configuration: The configuration to use, by default ``SlugConfiguration/standard``.
    func slugified(
        configuration: SlugConfiguration = .standard
    ) -> String {
        let chars = configuration.allowedCharacterSet.inverted
        let separator = configuration.separator
        return slugifiableValue.lowercased()
            .components(separatedBy: chars)
            .filter { !$0.isEmpty }
            .joined(separator: separator)
    }
}

extension String: Slugifiable {

    public var slugifiableValue: String { self }
}
