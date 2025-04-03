# ``TagKit``

TagKit is a Swift SDK that makes it easy to work with tags and slugification in `Swift` and `SwiftUI`.



## Overview

![TagKit logo](Logo.png)

TagKit is a Swift SDK that makes it easy to work with tags and slugified strings in `Swift` and `SwiftUI`.

You can slug and tag any type, customize the slug format, and use the built-in views to list and edit tags with ease.



## Installation

TagKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/TagKit.git
```



## Getting started

TagKit lets you slugify strings and manage tags for any taggable type.


### Slugs

Slugifying a string means to remove unwanted characters and replacing whitespaces with a separator. This is often used in urls, where a page slug creates a unique, valid url that also describes the content.

TagKit has a ``Swift/String/slugified(with:)`` string extension that lets you slugify strings with a standard or custom ``SlugConfiguration``:

```
let custom = SlugConfiguration(
    separator: "+",
    allowedCharacters: .init(charactersIn: "hewo")
)

"Hello, world!".slugified()             // "hello-world" 
"Hello, world!".slugified(with: custom) // "he+wo"
```

Slugified strings are automatically lowercased, since a slug should be case-insensitively unique.


### Tags

Tagging is the process of adding tags to an item, with the intent to categorize, group, filter and search among tags.

TagKit has a ``Taggable`` protocol that can be implemented by any type that has mutable ``Taggable/tags``:

```swift
public protocol Taggable {

    var tags: [String] { get set }
}
```

Once a type implements ``Taggable``, it can make use of a lot of automatically implemented functionality that the protocol provides, like ``Taggable/hasTags``, ``Taggable/slugifiedTags``, ``Taggable/addTag(_:)``, ``Taggable/removeTag(_:)``, ``Taggable/toggleTag(_:)``. All ``Taggable`` collections are extended as well.


### Views

TagKit has a bunch of tag related types, like ``TagCapsule``, ``TagList``, ``TagEditList`` and ``TagTextField``.




## Repository

For more information, source code, and to report issues, sponsor the project etc., visit the [project repository](https://github.com/danielsaidi/TagKit).



## License

TagKit is available under the MIT license.



## Topics

### Slugs

- ``SlugConfiguration``

### Tags

- ``Taggable``

### Views

- ``TagCapsule``
- ``TagCapsuleStyle``
- ``TagEditList``
- ``TagList``
- ``TagListContainer``
- ``TagTextField``
