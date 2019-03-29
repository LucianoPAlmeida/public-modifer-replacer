
import Foundation
import SwiftSyntax

public class PublicModifierExtensionRewriter: SyntaxRewriter {
    
    var blankModifier: DeclModifierSyntax
    
    public override init() {
        blankModifier = SyntaxFactory.makeBlankDeclModifier()
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
            return node.withModifiers(modifiers.replacing(childAt: publicModifier.indexInParent, with: blankModifier))
        }
        return node
    }
    
    
}

fileprivate func searchExtensionDeclParent(node: Syntax?) -> ExtensionDeclSyntax? {
    guard let node = node else { return nil }
    if let extensionDecl = node.parent as? ExtensionDeclSyntax {
        return extensionDecl
    } else {
        return searchExtensionDeclParent(node: node.parent)
    }    
}
