# Release notes

TagKit will use semver after 1.0.


## 0.2

This version bumps the package to Swift 5.9 and adds support for visionOS.

This version also bumps the deployment targets to make it possible to add more features. 

### ✨ Features
swfi
* `FlowLayout` is now public.
* `TagCapsuleStyle` now supports specifying a background material as well.

### 💡 Behavior Changes

* `TagCapsule` now applies a `TagCapsuleStyle`.



## 0.1.1

This version adjusts the tag capsule border to be rendered as an overlay. 



## 0.1

This version is the first public beta release of TagKit. 

### ✨ Features

* `Slugifiable` is a protocol that describes slugifiable types and adds additional functionality to any types that implement it.
* `SlugConfiguration` can be used to customized the slugified result.
* `Taggable` is a protocol that describes taggable types and adds additional functionality to any types that implement it and collections that contain them.
* `TagList` renders a collection of tags using a custom view builder.
* `TagEditList` renders a collection of toggleable tags using a custom view builder.
* `TagCapsule` renders a tag with a customizable style.
* `TagTextField` automatically slugifies any text that is entered into it.
