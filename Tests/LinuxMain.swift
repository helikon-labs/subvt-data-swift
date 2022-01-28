import XCTest

import SubVTDataTests

var tests = [XCTestCaseEntry]()
tests += AppServiceTests.allTests()
tests += NetworkStatusServiceTests.allTests()
tests += ReportServiceTests.allTests()
XCTMain(tests)
