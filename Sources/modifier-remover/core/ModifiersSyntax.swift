//
//  ModifiersSyntax.swift
//  modifier-remover-core
//
//  Created by Luciano Almeida on 28/03/19.
//

import SwiftSyntax

protocol ModifiersSyntax: Syntax {
    var modifiers: ModifierListSyntax? { get }
    func withModifiers(
        _ newChild: ModifierListSyntax?) -> Self
}

extension VariableDeclSyntax: ModifiersSyntax { }
extension FunctionDeclSyntax: ModifiersSyntax { }
