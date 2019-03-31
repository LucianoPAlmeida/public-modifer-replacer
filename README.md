# Public Modifier Remover

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)
[![Travis](https://img.shields.io/travis/LucianoPAlmeida/variable-injector.svg)](https://travis-ci.org/LucianoPAlmeida/variable-injector)
[![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-blue.svg)](https://developer.apple.com/xcode)
[![SPM](https://img.shields.io/badge/SPM-orange.svg)](https://swift.org/package-manager/)

Project 423 `'public' modifier is redundant for instance method declared in a public extension` warnings.  So, no way we are going to remove it by hand 😂.

This is just a simple tool to remove the redundant public modifier for public extensions fixing the Xcode warnings.

The project uses [SwiftSyntax](https://github.com/apple/swift-syntax) to perform a reliable substitutions of static literal strings with the CI environment variables values. 

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