# ``TagKit``

TagKit makes it easy to use tags and slugified strings in Swift and SwiftUI.



## Overview

![TagKit logo](Logo.png)

TagKit makes it easy to tag and slugify any type in Swift and SwiftUI. You can make any type implement ``Taggable`` & ``Slugifiable``, and use ``TagList`` to list tags and ``TagToggleList`` to list tags that can be toggled on and off.



## Installation

TagKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/TagKit.git
```



## Getting started

The two main areas of TagKit is to make it easy to manage tags and to slugify strings.


### Tags

Tagging items make it possible to categorize, group, filter and search among items, based on their tags. TagKit has a ``Tagged`` protocol for types with immutable ``Tagged/tags`` and a ``Taggable`` protocol for types with mutable tags.

```
struct MyModel: Tagged {

    var tags: [String] {
        return ["Tag 1", "Tag 2", "Tag 3"]
    }
}

let value = MyModel()
value.tags()             // ["Tag 1", "Tag 2", "Tag 3"] 
value.slugifiedTags()    // ["tag-1", "tag-2", "tag-3"]
value.hasTag("Tag 1")    // true
value.hasTag("Tag 4")    // false
```

All ``Tagged`` types are extended with properties and functions like ``Tagged/hasTags``, ``Tagged/hasTag(_:)``, ``Tagged/slugifiedTags``, etc. while ``Taggable`` types are extended with mutable functions like ``Taggable/addTag(_:)``, ``Taggable/removeTag(_:)``, ``Taggable/toggleTag(_:)``, etc.

TagKit has tag-related views like ``TagList``, ``TagToggleList`` and ``TagTextField``. You can apply a ``SwiftUICore/View/tagFlow(_:)`` view modifier to control the flow of tags in a list, and ``SwiftUICore/View/tagCapsule(style:)`` to convert a view into a tag capsule. 


### Slugs

Slugifying means to remove unwanted characters and replacing whitespaces with a separator to get a unique identifier that can be used in e.g. URLs. TagKit has a ``Slugifiable`` protocol that makes it easy to slugify type values.

```
let custom = SlugConfiguration(
    separator: "+",
    allowedCharacters: .init(charactersIn: "hewo")
)

"Hello, world!".slugified()             // "hello-world" 
"Hello, world!".slugified(with: custom) // "he+wo"
```

A ``Slugifiable`` type must provide a ``Slugifiable/slugValue`` after which you can use ``Slugifiable/slugified(with:)`` to create a slugified representation of the type. You can use a custom ``SlugConfiguration`` or the ``SlugConfiguration/standard`` one.



## Repository

For more information, source code, and to report issues, sponsor the project etc., visit the [project repository](https://github.com/danielsaidi/TagKit).



## License

TagKit is available under the MIT license.



## Topics

### Slugs

- ``Slugifiable``
- ``SlugConfiguration``

### Tags

- ``Tagged``
- ``Taggable``

### Tags UI

- ``TagCapsuleStyle``
- ``TagFlow``
- ``TagList``
- ``TagTextField``
- ``TagToggleList``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
