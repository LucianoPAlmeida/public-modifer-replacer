
import Foundation
import SwiftSyntax

public class PublicModifierExtensionRewriter: SyntaxRewriter {

    //This is a workaround because when we replaced or removed the public modifier when it was the first modifier, it end up losing the leading trivia info and the result was an unindented decl.
    private func makeNewLineSpacesModifier(withLeadingTrivia trivia: Trivia?) -> DeclModifierSyntax {
        guard let trivia = trivia else { return SyntaxFactory.makeBlankDeclModifier() }
        
        let spaces: String = (0..<trivia.sourceLength.columnsAtLastLine).map({ _ in return " " }).joined()
        let newLines: String = (0..<trivia.sourceLength.newlines).map({ _ in return "\n" }).joined()
        
        return SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeUnknown(""),
                                              detailLeftParen: nil,
                                              detail: SyntaxFactory.makeUnknown(newLines + spaces),
                                              detailRightParen: nil)
    }
    
    override public func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        let newLineTabModifier = makeNewLineSpacesModifier(withLeadingTrivia: node.leadingTrivia)
        return replacePublicModifier(node: node, newLineTabModifier: newLineTabModifier)
    }
    
    public override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        let newLineTabModifier = makeNewLineSpacesModifier(withLeadingTrivia: node.leadingTrivia)
        return replacePublicModifier(node: node, newLineTabModifier: newLineTabModifier)
    }
    
    func replacePublicModifier<M: ModifiersSyntax>(node: M, newLineTabModifier: DeclModifierSyntax) -> M {
        guard let modifiers = node.modifiers else { return node }
        guard let extDecl = searchExtensionDeclParent(node: node), extDecl.isPublicExtension else {
            print("Is NOT declared on a extension, so we don't need to remove")
            return node
        }
        if let publicModifier = modifiers.first(where: { $0.name.tokenKind == .publicKeyword }) {
            var newModifiers = modifiers.removing(childAt: publicModifier.indexInParent)
            if publicModifier.indexInParent == 0 {
                newModifiers = newModifiers.inserting(newLineTabModifier, at: 0)
            }
            return node.withModifiers(newModifiers)
        }
        return node
    }
    
    
}

// Finding the Extension Decl parent. 
fileprivate func searchExtensionDeclParent(node: Syntax?) -> ExtensionDeclSyntax? {
    guard let node = node else { return nil }
    if let extensionDecl = node.parent as? ExtensionDeclSyntax {
        return extensionDecl
    } else {
        return searchExtensionDeclParent(node: node.parent)
    }    
}
