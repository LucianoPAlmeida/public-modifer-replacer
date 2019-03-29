import SwiftSyntax
import Foundation
import Path

import modifier_remover_core

func rewrite(source: Path) throws {
    let sourceFile = try SyntaxTreeParser.parse(source.url)
    
    let rewriter = PublicModifierExtensionRewriter()
    
    let result = rewriter.visit(sourceFile)
    
    var contents: String = ""
    result.write(to: &contents)
    
    print(contents)
    
    //try? contents.write(to: url, atomically: true, encoding: .utf8)
}

guard CommandLine.arguments.count > 1, let path = Path(CommandLine.arguments[1]) else {
    fatalError("You should provide a folder")
}

var files: [Path] = []

if path.isFile && path.extension == "swift" {
    files.append(path)
} else {
    files = try path.ls().files(withExtension: "swift")
}

for file in files {
    print("Rewriting \(file.basename())")
    try rewrite(source: file)
}
