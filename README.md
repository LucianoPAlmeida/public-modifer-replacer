# Public Modifier Remover

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)
[![Travis](https://img.shields.io/travis/LucianoPAlmeida/public-modifer-replacer.svg)](https://travis-ci.org/LucianoPAlmeida/public-modifer-replacer)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.2-blue.svg)](https://developer.apple.com/xcode)
[![SPM](https://img.shields.io/badge/SPM-orange.svg)](https://swift.org/package-manager/)

Project  has 400+ `'public' modifier is redundant for instance method declared in a public extension` warnings.  So, no way we are going to remove it by hand 😂.

This is just a simple tool to remove the redundant public modifier for public extensions fixing the Xcode warnings.

The project uses [SwiftSyntax](https://github.com/apple/swift-syntax).

## Installation

Or just clone the repo and run `cmake install`

With that installed and on our `bin` folder, now we can use it.

## Usage

Just run the command passing the folder to your source files.

```sh
modifier-remover /path/to/our/source/files/
```
## Licence
Public Modifier Remover is released under the [MIT License](https://opensource.org/licenses/MIT).
