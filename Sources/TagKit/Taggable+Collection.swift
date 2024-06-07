//
//  Taggable+Collection.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-06-30.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

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
