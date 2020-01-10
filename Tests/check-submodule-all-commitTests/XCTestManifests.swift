import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(check_submodule_all_commitTests.allTests),
    ]
}
#endif
