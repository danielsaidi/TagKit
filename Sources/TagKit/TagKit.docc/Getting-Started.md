#  Getting Started

This article describes how to get started with TagKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}



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

`String` implements this protocol by returning itself as the slugifiable value. It's also easy to make any type conform to the protocol:

```swift
struct Person: Slugifiable {

    let firstName: String
    let lastName: String
    let age: Int

    var slugifiableValue: String { 
        "\(firstName) \(lastName)" 
    }
}
```

Any type that implements ``Slugifiable`` can be slugified with ``Slugifiable/slugified(configuration:)``:

```swift
let string = "Hello, world!"
let person = Person(firstName: "John", lastName: "Doe", age: -1)

string.slugified() // -> "hello-world"
person.slugified() // -> "john-doe"
```

You can provide a custom ``SlugConfiguration`` to customize the slugified result:

```swift
let string = "Hello, world!"
let config = SlugConfiguration(
    separator: "+",
    allowedCharacters: .init(charactersIn: "hewo")
)
string.slugified(configuration: config) // -> "he+wo"
```

You probably won't need to use these functions and custom configurations, but if you have to, you have great flexibility to do so.


### Taggable types

Tagging (or labeling) is the process of adding tags to items, with the intent to be able to categorize, group, filter and search these items.

In TagKit, the ``Taggable`` protocol describes a taggable type:

```swift
public protocol Taggable {

    var tags: [String] { get set }
}
```

Once a type implements ``Taggable``, it can make use of a lot of automatically implemented functionality that the protocol provides, like ``Taggable/hasTags``, ``Taggable/slugifiedTags``, ``Taggable/addTag(_:)``, ``Taggable/removeTag(_:)``, ``Taggable/toggleTag(_:)``, and much more. 

Collections of ``Taggable`` types also get additional functionality as well.


## Views

TagKit also has a few views that aim at making it easier to work with tags. 

For instance, ``TagList`` and ``TagEditList`` let you list and edit tags, ``TagCapsule`` renders tags with a customizable style and ``TagTextField`` automatically slugifies text as you type.
