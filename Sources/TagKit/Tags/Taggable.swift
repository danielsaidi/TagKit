//
//  Taggable.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-06.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by types that have tags
/// that can be mutated.
///
/// Types that implement this protocol get access to a bunch
/// of additional features, like ``toggleTag(_:)``.
///
/// Note that the ``tags`` property returns raw strings. You
/// can get slugified variants with ``slugifiedTags``.
public protocol Taggable: Tagged {

    /// All tags that have been applied to the item.
    var tags: [String] { get set }
}

public extension Taggable {

    /// Add a tag to the taggable type.
    mutating func addTag(_ tag: String) {
        if hasTag(tag) { return }
        tags.append(tag)
    }

    /// Remove a tag from the taggable type.
    mutating func removeTag(_ tag: String) {
        guard hasTag(tag) else { return }
        tags = tags.filter { $0 != tag }
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
