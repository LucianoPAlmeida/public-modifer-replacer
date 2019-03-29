import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(modifier_removerTests.allTests),
    ]
}
#endif
