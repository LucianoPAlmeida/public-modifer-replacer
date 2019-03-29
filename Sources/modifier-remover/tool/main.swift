import SwiftSyntax
import Foundation
import modifier_remover_core

let url = URL(string: "file:/Users/lucianoalmeida/Documents/Programming/OpenProjects/Community/SwifterSwift/Sources/Extensions/SwiftStdlib/DictionaryExtensions.swift")!

let sourceFile = try SyntaxTreeParser.parse(url)

let rewriter = PublicModifierExtensionRewriter()

let result = rewriter.visit(sourceFile)

var contents: String = ""
result.write(to: &contents)

print(contents)

//try? contents.write(to: url, atomically: true, encoding: .utf8)
