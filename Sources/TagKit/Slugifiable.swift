//
//  Slugifiable.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// converted to a slugified string.
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
        slugifiableValue.lowercased()
            .components(separatedBy: configuration.notAllowedCharacterSet)
            .filter { !$0.isEmpty }
            .joined(separator: configuration.separator)
    }
}

extension String: Slugifiable {

    public var slugifiableValue: String { self }
}
