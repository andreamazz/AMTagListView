# Change Log
All notable changes to this project will be documented in this file.
`AMTagListView` adheres to [Semantic Versioning](http://semver.org/).

- `1.5.x` Releases - [1.5.0](#150)
- `1.4.x` Releases - [1.4.0](#140)
- `1.3.x` Releases - [1.3.0](#130)
- `1.2.x` Releases - [1.2.0](#120)
- `1.1.x` Releases - [1.1.0](#110)
- `1.0.x` Releases - [1.0.0](#100)
- `0.9.x` Releases - [0.9.0](#090)
- `0.8.x` Releases - [0.8](#08) | [0.8.1](#081)
- `0.7.x` Releases - [0.7](#07) | [0.7.1](#071)

---

## [1.5.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.5.0)

#### Added

- Merged #53

## [1.4.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.4.0)

#### Added

- Delegate method called when a tag is deleted.  

## [1.3.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.3.0)

#### Added

- Tags can now be generic `UIView`s conforming to the `AMTag` protocol. See #60

## [1.2.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.2.0)

#### Added  

- `tagList:shouldAddTagsWithText:resultingContentSize:`

## [1.1.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.1.0)

#### Added  

- `addTag:withUserInfo:` to add a payload to tags. Thanks to [nsolter](https://github.com/nsolter)  

## [1.0.0](https://github.com/andreamazz/AMTagListView/releases/tag/1.0.0)

Stable release

#### Changed  

- `tagText` on `AMTagView` is now read-write  

## [0.9.0](https://github.com/andreamazz/AMTagListView/releases/tag/0.9.0)

#### Changed  

- `textPadding` is now a `CGPoint`

## [0.8.1](https://github.com/andreamazz/AMTagListView/releases/tag/0.8.1)

#### Fixed  
- Changes in text color updates the view properly  

## [0.8](https://github.com/andreamazz/AMTagListView/releases/tag/0.8)

#### Added  
- Support to Carthage

## [0.7.1](https://github.com/andreamazz/AMTagListView/releases/tag/0.7.1)

#### Updated  
- Minor refactoring

## [0.7](https://github.com/andreamazz/AMTagListView/releases/tag/0.7)

#### Added  
- Support to right to left alignment via `tagAlignment`  
