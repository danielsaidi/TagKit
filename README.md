<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="TagKit Logo" title="TagKit" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/TagKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.6-orange.svg" alt="Swift 5.6" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/TagKit" alt="MIT License" />
    <img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" />
    <img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" />
</p>


## About TagKit

TagKit makes it easy to work with tags and slugification in `Swift` and `SwiftUI`. 

The result can look like this or completely different: 

<p align="center">
    <img src="Resources/Demo.gif" width=300 />
</p>

Tags and views can be customized to fit your specific needs. You can change the slug format and tag any custom models, and when presenting tags you can apply custom styling and use any views you like.



## Installation

TagKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/TagKit.git
```

or with CocoaPods:

```
pod TagKit
```

If you prefer not having external dependencies, you can also just copy the source code into your app.



## Supported Platforms

TagKit supports `iOS 13`, `macOS 11`, `tvOS 13` and `watchOS 6`.



## Getting started

The [online documentation][Documentation] has a [getting-started guide][Getting-Started] that will help you get started with the library.

In TagKit, you can use the `Slugifiable` protocol to describe slufiable types. `String` implements this protocol by returning itself as the slugifiable value. You can then use the `slugified()` function on any `Slugifiable` type to get a slugified value that accounts for spaces, unwanted characters etc.

With slugified strings in place, we can then use the `Taggable` protocol to describe taggable types. Once a type implements `Taggable`, it can make use of all the functionality that the protocol provides, such as adding or removing tags, check if a tag has been added etc.

Finally, TagKit has a couple of views to list and edit tags. For more information, please see the [online documentation][Documentation] and [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] contains more information, code examples, etc., and makes it easy to overview the various parts of the library. 



## Demo Application

I will create a demo application for this package once it gets 100+ stars.



## Support

You can sponsor this project on [GitHub Sponsors][Sponsors] or get in touch for paid support. 



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

TagKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/TagKit/documentation/tagkit/
[Getting-Started]: https://danielsaidi.github.io/TagKit/documentation/tagkit/getting-started
[License]: https://github.com/danielsaidi/TagKit/blob/master/LICENSE
