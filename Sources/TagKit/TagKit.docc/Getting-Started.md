#  Getting Started

This article describes how you get started with TagKit.


## Installation

TagKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/TagKit.git
``` 

or with CocoaPods:

```
pod TagKit
```

## Tagging with TagKit

Before we look at tagging, let's start with looking at slugifying strings, which is the process of converting a string to a slug by removing unsupported characters and replacing whitespace with a separator.


### Slugifying strings

You can see slugified strings in action in many web urls, where the page date and title is often slugified to create a unique valid url that also describes the content. 

In TagKit, the ``Slugifiable`` protocol describes a slugifyable type:

```swift
public protocol Slugifiable {

    var slugifiableValue: String { get }
}
```

`String` implements this protocol by default, by returning itself as the slugifiable value.

Once a type implements ``Slugifiable``, it can be slugified with the `slugified()` function:

```swift
let string = "Hello, world!"
let slug = string.slugified() // Returns "hello-world"
```

You can also provide a custom ``SlugConfiguration`` to customize the slugified result:

```swift
let string = "Hello, world!"
let config = SlugConfiguration(
    separator: "+",
    allowedCharacters: NSCharacterSet(charactersIn: "hewo")
)
let slug = string.slugified() // Returns "he+wo"
```

You probably won't need to use these functions directly, nor customize the configuration, but if you have to, you can.


### Taggable types

With slugified strings in place, we can start looking at tagging, which is the process of adding tags (or labels) to items, which can be used to group, filter etc.

In TagKit, the ``Taggable`` protocol describes a taggable type:

```swift
public protocol Taggable {

    var tags: [String] { get set }
}
```

Once a type implements ``Taggable``, it can make use of all the functionality that the protocol provides, such as `hasTags`, `slugifiedTags`, `hasTag(...)`, `addTag(...)`, `removeTag(...)`, `toggleTag(...)` etc. 

Collections that contain ``Taggable`` types also get some additional functionality as well.


## Views

TagKit will contain a couple of views to simplify working with tags.

More information coming soon.
