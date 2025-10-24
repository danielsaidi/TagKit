//
//  Tags.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-06.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be tagged.
///
/// Types that implement this protocol get access to a bunch of additional features,
/// e.g. ``hasTags``, ``addTag(_:)``, ``toggleTag(_:)``, etc.
///
/// Note that the ``tags`` property is a raw string list. If you want a slugified tag
/// collection, use ``slugifiedTags``.
public protocol Taggable {

    /// All tags that have been applied to the item.
    var tags: [String] { get set }
}

public extension Taggable {

    /// Whether or not the item has any tags.
    var hasTags: Bool {
        !tags.isEmpty
    }

    /// Get a list of slugified ``tags``.
    var slugifiedTags: [String] {
        slugifiedTags()
    }

    /// Add a tag to the taggable type.
    mutating func addTag(_ tag: String) {
        if hasTag(tag) { return }
        tags.append(tag)
    }

    /// Whether or not the item has a certain tag.
    func hasTag(_ tag: String) -> Bool {
        if tag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return true }
        return slugifiedTags.contains(tag.slugified())
    }

    /// Remove a tag from the taggable type.
    mutating func removeTag(_ tag: String) {
        guard hasTag(tag) else { return }
        tags = tags.filter { $0 != tag }
    }

    /// Get a list of slugified ``tags``.
    ///
    /// - Parameters:
    ///   - config: The slug configuration to use, by default ``SlugConfiguration/standard``.
    func slugifiedTags(
        configuration: SlugConfiguration = .standard
    ) -> [String] {
        tags.map { $0.slugified(with: configuration) }
    }

    /// Toggle a tag on the taggable type.
    mutating func toggleTag(_ tag: String) {
        if hasTag(tag) {
            removeTag(tag)
        } else {
            addTag(tag)
        }
    }
}

public extension Collection where Element: Taggable {

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
