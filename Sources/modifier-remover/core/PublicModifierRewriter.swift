import Foundation
import SwiftSyntax

public class PublicModifierExtensionRewriter: SyntaxRewriter {
  
  private func makeNewLineSpacesModifier(withLeadingTrivia trivia: Trivia?) -> DeclModifierSyntax {
    guard let trivia = trivia else { return SyntaxFactory.makeBlankDeclModifier() }
    return SyntaxFactory.makeBlankDeclModifier().withDetail(
      SyntaxFactory.makeUnknown("").withLeadingTrivia(trivia)
    )
  }
  
  public override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    return DeclSyntax(replacePublicModifier(node: node))
  }
  
  public override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    return DeclSyntax(replacePublicModifier(node: node))
  }
  
  func replacePublicModifier<M: ModifiersSyntax>(node: M) -> M {
    guard let modifiers = node.modifiers else { return node }
    guard let extDecl = searchExtensionDeclParent(node: node), extDecl.isPublicExtension else {
      debugPrint("Is NOT declared on a public extension, so we don't need to remove public modifier")
      return node
    }
    
    guard let publicModifier = modifiers.first(where: { $0.name.tokenKind == .publicKeyword }) else {
      return node
    }

    if publicModifier.indexInParent == 0 {
      let newLineTabModifier = makeNewLineSpacesModifier(withLeadingTrivia: publicModifier.leadingTrivia)
      return node.withModifiers(modifiers.replacing(childAt: 0, with: newLineTabModifier))
    }
    return node.withModifiers(modifiers.removing(childAt: publicModifier.indexInParent))
  }
}

// Finding the Extension Decl parent. 
private func searchExtensionDeclParent(node: SyntaxProtocol) -> ExtensionDeclSyntax? {
  guard let parent = node.parent else { return nil }
  if let extensionDecl = parent.as(ExtensionDeclSyntax.self) {
    return extensionDecl
  }
  return searchExtensionDeclParent(node: parent)
}
