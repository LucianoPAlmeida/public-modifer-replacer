import XCTest
import class Foundation.Bundle
import SwiftSyntax
import modifier_remover_core


final class modifier_removerTests: XCTestCase {
    
  let testSource = """
        public extension Int {

            public func f() -> Int {
                return self * self
            }

            static public func f2() {
            }

            public static func f3() {
            }
        }
    """
    
  let expectedTestSource = """
        public extension Int {

            func f() -> Int {
                return self * self
            }

            static func f2() {
            }

            static func f3() {
            }
        }
    """
    
  let testNonPublicSource = """
        extension Int {

            public func f() -> Int {
                return self * self
            }

            static public func f2() {
            }

            public static func f3() {
            }
        }
    """
  
  func testSubstitutionPublicExtension() throws {
    let sourceFile = try SyntaxParser.parse(source: testSource)
    
    let publicRewriter = PublicModifierExtensionRewriter()
    let result = publicRewriter.visit(sourceFile)
    
    var contents: String = ""
    result.write(to: &contents)
    
    XCTAssertEqual(expectedTestSource, contents)
  }
  
  func testSubstitutionPublicNonExtension() throws {
    let sourceFile = try SyntaxParser.parse(source: testNonPublicSource)
    
    let publicRewriter = PublicModifierExtensionRewriter()
    let result = publicRewriter.visit(sourceFile)
    
    var contents: String = ""
    result.write(to: &contents)
    
    XCTAssertEqual(testNonPublicSource, contents)
  }
  
  static var allTests = [
    ("testSubstitutionPublicExtension", testSubstitutionPublicExtension),
    ("testSubstitutionPublicNonExtension", testSubstitutionPublicNonExtension),
  ]
}
