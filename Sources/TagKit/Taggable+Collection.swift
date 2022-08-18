//
//  Taggable+Collection.swift
//  TagKit
//
//  Created by Daniel Saidi on 2022-06-30.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Collection where Element: Taggable {

    /**
     Get all the slugified tags in the collection.

     The tags are slugified to remove any casing and spacing
     differences that may exist between the items.
     */
    var allTags: [String] {
        let slugs = flatMap { $0.slugifiedTags }
        return Array(Set(slugs)).sorted()
    }

    /**
     Get all items in the collection that have a certain tag.
     */
    func withTag(_ tag: String) -> [Element] {
        filter { $0.hasTag(tag) }
    }
}
