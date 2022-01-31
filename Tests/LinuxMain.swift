import XCTest

import SubVTDataTests

var tests = [XCTestCaseEntry]()
tests += AppServiceTests.allTests()
tests += NetworkStatusServiceTests.allTests()
tests += ReportServiceTests.allTests()
tests += ValidatorDetailsServiceTests.allTests()
tests += ValidatorListServiceTests.allTests()
XCTMain(tests)
