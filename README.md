<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/TagKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://danielsaidi.github.io/TagKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <img src="https://img.shields.io/github/license/danielsaidi/TagKit" alt="MIT License" />
</p>



# TagKit

TagKit is a Swift SDK that makes it easy to work with tags and slugify strings in `Swift` and `SwiftUI`.

<p align="center">
    <img src="Resources/Demo-v2.gif" width=450 />
</p>

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



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Support this library

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



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
