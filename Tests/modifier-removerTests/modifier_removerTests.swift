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
    
    let testFileName: String = "TestFile.swift"
    let testFileNameNonPublic: String = "TestFile-NonPublic.swift"
    
    override func setUp() {
        // Work around https://bugs.swift.org/browse/SR-2866
        try? testSource.write(to: Bundle(for: type(of: self)).bundleURL.appendingPathComponent(testFileName), atomically: true, encoding: .utf8)
        try? testNonPublicSource.write(to: Bundle(for: type(of: self)).bundleURL.appendingPathComponent(testFileNameNonPublic), atomically: true, encoding: .utf8)
    }
    
    func testSubstitutionPublicExtension() throws {
        let url = Bundle(for: type(of: self)).bundleURL.appendingPathComponent(testFileName)
        let sourceFile = try SyntaxTreeParser.parse(url)
        
        let publicRewriter = PublicModifierExtensionRewriter()
        let result = publicRewriter.visit(sourceFile)
        
        var contents: String = ""
        result.write(to: &contents)
        
        XCTAssertEqual(expectedTestSource, contents)
    }
    
    func testSubstitutionPublicNonExtension() throws {
        let url = Bundle(for: type(of: self)).bundleURL.appendingPathComponent(testFileNameNonPublic)
        let sourceFile = try SyntaxTreeParser.parse(url)
        
        let publicRewriter = PublicModifierExtensionRewriter()
        let result = publicRewriter.visit(sourceFile)
        
        var contents: String = ""
        result.write(to: &contents)
        print(contents)
        XCTAssertEqual(testNonPublicSource, contents)
    }
    
    static var allTests = [
        ("testSubstitutionPublicExtension", testSubstitutionPublicExtension),
        ("testSubstitutionPublicNonExtension", testSubstitutionPublicNonExtension),
    ]
}
