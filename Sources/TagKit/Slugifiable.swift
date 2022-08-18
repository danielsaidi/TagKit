//
//  Slugifiable.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol describes a type that can be slugified into a
 slug representation that can be used in e.g. tags.

 Types that implement this protocol get access to a bunch of
 additional functionality, e.g. ``slugified(configuration:)``.

 When slugifying, "Hello there, friends!" will by default be
 converted to `hello-there-friends`, but this format depends
 on the ``SlugConfiguration`` that is used.

 This protocol is automatically implemented by `String`.
 */
public protocol Slugifiable {

    /**
     The slugifiable value that will be used when creating a
     slugified string.
     */
    var slugifiableValue: String { get }
}

public extension Slugifiable {

    /**
     Convert the slugifiable value to a slugified string.

     With the default configuration, `I'd love an AppleCar!`
     will be slugified as `i-d-love-an-apple-car`.

     - Parameters:
       - configuration: The configuration to use, by default ``SlugConfiguration/standard``.
     */
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

    /**
     The sluggable value that will be used when creating the
     slugified result.
     */
    public var slugifiableValue: String { self }
}
