import Foundation
import SwiftSyntax

public class PublicModifierExtensionRewriter: SyntaxRewriter {

    private func makeNewLineSpacesModifier(withLeadingTrivia trivia: Trivia?) -> DeclModifierSyntax {
        guard let trivia = trivia else { return SyntaxFactory.makeBlankDeclModifier() }

        return SyntaxFactory.makeDeclModifier(name: SyntaxFactory.makeUnknown(""),
                                              detailLeftParen: nil,
                                              detail: SyntaxFactory.makeUnknown("").withLeadingTrivia(trivia),
                                              detailRightParen: nil)
    }

    override public func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        return replacePublicModifier(node: node)
    }

    public override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        return replacePublicModifier(node: node)
    }

    func replacePublicModifier<M: ModifiersSyntax>(node: M) -> M {
        guard let modifiers = node.modifiers else { return node }
        guard let extDecl = searchExtensionDeclParent(node: node), extDecl.isPublicExtension else {
            print("Is NOT declared on a extension, so we don't need to remove")
            return node
        }
        if let publicModifier = modifiers.first(where: { $0.name.tokenKind == .publicKeyword }) {
            if publicModifier.indexInParent == 0 {
                let newLineTabModifier = makeNewLineSpacesModifier(withLeadingTrivia: publicModifier.leadingTrivia)
                return node.withModifiers(modifiers.replacing(childAt: 0, with: newLineTabModifier))
            } else {
                return node.withModifiers(modifiers.removing(childAt: publicModifier.indexInParent))
            }
        }
        return node
    }

}

// Finding the Extension Decl parent. 
private func searchExtensionDeclParent(node: Syntax?) -> ExtensionDeclSyntax? {
    guard let node = node else { return nil }
    if let extensionDecl = node.parent as? ExtensionDeclSyntax {
        return extensionDecl
    } else {
        return searchExtensionDeclParent(node: node.parent)
    }
}
