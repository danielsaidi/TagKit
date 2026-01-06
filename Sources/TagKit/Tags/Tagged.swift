//
//  Tagged.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-06.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by types that have tags.
///
/// Types that implement this protocol get access to a bunch
/// of additional features, like ``hasTags``.
///
/// Note that the ``tags`` property returns raw strings. You
/// can get slugified variants with ``slugifiedTags``.
public protocol Tagged {

    /// All tags that have been applied to the item.
    var tags: [String] { get }
}

public extension Tagged {

    /// Whether or not the item has any tags.
    var hasTags: Bool {
        !tags.isEmpty
    }

    /// Get a list of slugified ``tags``.
    ///
    /// This property uses a standard slug configuration.
    var slugifiedTags: [String] {
        slugifiedTags(withConfiguration: .standard)
    }

    /// Whether or not the item has a certain tag.
    func hasTag(_ tag: String) -> Bool {
        if tag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return true }
        return slugifiedTags.contains(tag.slugified())
    }

    /// Get a list of slugified ``tags``.
    ///
    /// - Parameters:
    ///   - configuration: The slug configuration to use.
    func slugifiedTags(
        withConfiguration configuration: SlugConfiguration
    ) -> [String] {
        tags.map { $0.slugified(with: configuration) }
    }
}

public extension Collection where Element: Tagged {

    /// Get all the slugified tags in the collection.
    ///
    /// Read more about slugified strings in ``Slugifiable``.
    var allTags: [String] {
        let slugs = flatMap { $0.slugifiedTags }
        return Array(Set(slugs)).sorted()
    }

    /// Get all items in the collection with a certain tag.
    func withTag(_ tag: String) -> [Element] {
        filter { $0.hasTag(tag) }
    }
}
