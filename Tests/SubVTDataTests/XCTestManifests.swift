import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AppServiceTests.allTests),
        testCase(ReportServiceTests.allTests),
    ]
}
#endif
