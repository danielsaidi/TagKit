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

All ``Tagged`` types are extended with properties and functions like ``Tagged/hasTags``, ``Tagged/hasTag(_:)``, ``Tagged/slugifiedTags``, etc. while ``Taggable`` types are extended with mutable functions like ``Taggable/addTag(_:)``, ``Taggable/removeTag(_:)``, ``Taggable/toggleTag(_:)``, etc.

TagKit has a bunch of tag-related views, like ``TagList``, ``TagEditList`` & ``TagTextField``. You can apply a ``SwiftUICore/View/tagFlow(_:)`` modifier to control the flow of tags in a list, and ``SwiftUICore/View/tagCapsule(style:)`` to convert a view into a tag capsule. 


### Slugs

Slugifying means to remove unwanted characters and replacing whitespaces with a separator to get a unique identifier that can be used in e.g. URLs. TagKit has a ``Slugifiable`` protocol that can be implemented by any type that should support this feature.

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
