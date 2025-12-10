# Release notes

[TagKit](https://github.com/danielsaidi/TagKit) will use semver after 1.0.

Until then, breaking changes can happen in any minor version.



## 0.6.1

This version re-introduces the `Slugifiable` protocol.



## 0.6

This version bumps the package to Swift 6.1.



## 0.5

This version makes TagKit use Swift 6, by removing the flow layout parts from the library.

The `TagList` and `TagEditList` is therefore much simpler now before, and can be used in more ways. 

### 💡 Behavior Changes

* `TagList` and `TagEditList` now just lists the provided tags.
* `TagList` and `TagEditList` can now be rendered in any layout container.

### 🗑️ Deprecated

* `Slugifiable` has been deprecated. Just use the `slugified` string extension instead.
* `TagCapsule` has been deprecated, since it's better to just customize a regular `Text`.

### 💥 Breaking Changes

* `FlowLayout` could not be refactored to support strict concurrency, and has been removed.



## 0.4.1

This version temporarily downgrades to Swift 5.9 since Xcode 16.1 made things stop working.



## 0.4

This version makes TagKit use Swift 6.



## 0.3

This version adds support for strict concurrency.

This requires standard styles to be converted to read-only values.

This version also adjusts the visual appearance of some standard styles.

### ✨ Features

* `TagCapsuleStyle` now supports specifying a shadow.

### 💡 Behavior Changes

* `TagCapsule.standard` and `.standardSelected` now use material backgrounds.



## 0.2

This version bumps the package to Swift 5.9 and adds support for visionOS.

This version also bumps the deployment targets to make it possible to add more features. 

### ✨ Features

* `FlowLayout` is now public.
* `TagCapsuleStyle` has new, material-based default styles.
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
