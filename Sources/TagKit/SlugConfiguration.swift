//
//  SlugConfiguration.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-18.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This configuration defines how ``Slugifiable`` types are to
 be slugified.

 Use the ``SlugConfiguration/standard`` configuration if you
 want the standard configuration, which limits the slugified
 strings to `a-z` and `1-9`, using `-` as separator.
 */
public struct SlugConfiguration {

    /**
     Create a new slug configurator.

     - Parameters:
       - separator: The separator to use in the slugified string, by default `-`.
       - allowedCharacters: The characters to allow in the slugified string, by default alphanumerical characters and `-`.
     */
    public init(
        separator: String = "-",
        allowedCharacters: NSCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    ) {
        self.separator = separator
        self.allowedCharacters = allowedCharacters
    }

    /**
     The separator to use in the slugified string.
     */
    public let separator: String

    /**
     The characters to allow in the slugified string.
     */
    public let allowedCharacters: NSCharacterSet
}

public extension SlugConfiguration {

    /**
     Create a standard slug configuration, which allows `a-z`
     and `1-9` and uses `-` as separator.
     */
    static let standard = SlugConfiguration()
}
