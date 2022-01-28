import XCTest

import SubVTDataTests

var tests = [XCTestCaseEntry]()
tests += AppServiceTests.allTests()
tests += ReportServiceTests.allTests()
XCTMain(tests)
