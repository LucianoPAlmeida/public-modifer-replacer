//
//  File+Helpers.swift
//  modifier-remover
//
//  Created by Luciano Almeida on 29/03/19.
//

import Path

func recursiveFiles(withExtension ext: String, at path: Path) throws -> [Path] {
    if path.isFile {
        if path.extension == ext {
            return [path]
        }
        return []
    } else if path.isDirectory {
        var files: [Path] = []
        for entry in path.ls() {
            let list = try recursiveFiles(withExtension: ext, at: entry.realpath())
            files.append(contentsOf: list)
        }
        return files
    }
    return []
}
