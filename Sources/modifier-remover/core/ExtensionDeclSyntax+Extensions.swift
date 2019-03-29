//
//  ExtensionDeclSyntax+Extensions.swift
//  SwiftSyntax
//
//  Created by Luciano Almeida on 28/03/19.
//

import SwiftSyntax

extension ExtensionDeclSyntax {
    var isPublicExtension: Bool {
        return modifiers?.contains(where: { $0.name.tokenKind == .publicKeyword }) ?? false
    }
}
