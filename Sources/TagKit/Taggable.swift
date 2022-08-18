//
//  Taggable.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-08-06.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol describe types that can be tagged with one or
 many tags, which can then be used to group, search etc.

 Types that implement this protocol get access to a bunch of
 additional functionality, e.g. ``hasTags``, ``addTag(_:)``.

 Note that the ``tags`` property is a raw list of tags, that
 should contain slugified tags. However, since this protocol
 can be implemented by any type, you can use ``slugifiedTags``
 to ensure that you get a list of slugified tags.
 */
public protocol Taggable {

    /**
     All tags that have been applied to the item.
     */
    var tags: [String] { get set }
}

public extension Taggable {

    /**
     Whether or not the item has any tags.
     */
    var hasTags: Bool {
        !tags.isEmpty
    }

    /**
     Get a list of slugified ``tags``.
     */
    var slugifiedTags: [String] {
        slugifiedTags()
    }

    /**
     Add a tag to the taggable type.
     */
    mutating func addTag(_ tag: String) {
        if hasTag(tag) { return }
        tags.append(tag)
    }

    /**
     Whether or not the item has a certain tag.
     */
    func hasTag(_ tag: String) -> Bool {
        if tag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return true }
        return slugifiedTags.contains(tag.slugified())
    }

    /**
     Remove a tag from the taggable type.
     */
    mutating func removeTag(_ tag: String) {
        guard hasTag(tag) else { return }
        tags = tags.filter { $0 != tag }
    }

    /**
     Get a list of slugified ``tags`` for a certain config.

     - Parameters:
       - config: The slug configuration to use, by default ``SlugConfiguration/standard``.
     */
    func slugifiedTags(
        configuration: SlugConfiguration = .standard
    ) -> [String] {
        tags.map { $0.slugified(configuration: configuration) }
    }

    /**
     Toggle a tag on the taggable type.
     */
    mutating func toggleTag(_ tag: String) {
        if hasTag(tag) {
            removeTag(tag)
        } else {
            addTag(tag)
        }
    }
}
