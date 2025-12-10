<p align="center">
    <img src="Resources/Icon-Badge.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/TagKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-6.1-orange.svg" alt="Swift 6.1" />
    <a href="https://danielsaidi.github.io/TagKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/TagKit/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/TagKit" alt="MIT License" /></a>
</p>



# TagKit

TagKit makes it easy to use tags and slugified strings in Swift and SwiftUI.

<p align="center">
    <img src="https://github.com/danielsaidi/TagKit/releases/download/0.5.0/Demo.gif" width=450 />
</p>

You can make any type implement ``Taggable`` and ``Slugifiable`` to manage tags and slugs. You can use ``TagList`` to list tags and ``TagToggleList`` to list tags that can be toggled on and off.




## Installation

TagKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/TagKit.git
```



## Getting started

The two main areas of TagKit is to make it easy to manage tags and to slugify strings.


### Tags

Tagging items make it possible to categorize, group, filter and search among items, based on their tags. TagKit has a ``Tagged`` protocol for types with immutable ``tags`` and a ``Taggable`` protocol for types with mutable tags.

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

All ``Tagged`` types are extended with properties and functions like ``hasTags``, ``hasTag(_:)``, ``slugifiedTags``, etc. ``Taggable`` types are extended with mutable functions like ``addTag(_:)``, ``removeTag(_:)``, ``toggleTag(_:)``, etc.

TagKit has tag-related views like ``TagList``, ``TagToggleList`` and ``TagTextField``. You can apply a ``tagFlow(_:)`` modifier to control the flow of tags in a list, and ``tagCapsule(style:)`` to convert a view into a tag capsule. 


### Slugs

Slugifying means to remove unwanted characters and replacing whitespaces to get a unique identifier that can be used in e.g. URLs. TagKit has a ``Slugifiable`` protocol that makes it easy to slugify type values.

```
let custom = SlugConfiguration(
    separator: "+",
    allowedCharacters: .init(charactersIn: "hewo")
)

"Hello, world!".slugified()             // "hello-world" 
"Hello, world!".slugified(with: custom) // "he+wo"
```

A ``Slugifiable`` type must provide a ``slugValue`` after which you can use ``slugified(with:)`` to create a slugified representation of the type. You can use a custom ``SlugConfiguration`` or the ``standard`` one.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

TagKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/TagKit
[License]: https://github.com/danielsaidi/TagKit/blob/master/LICENSE
