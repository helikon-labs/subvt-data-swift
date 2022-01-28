import Combine
import XCTest
@testable import SubVTData

final class ReportServiceTests: BaseTest {
    private var cancellables: Set<AnyCancellable>!
    private let service = ReportService()
    private let validatorAccountId = AccountId(
        hex: "0xa00505eb2a4607f27837f57232f0c456602e39540582685b4f58cde293f1a116"
    )
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test01GetSingleEraReport() {
        testServiceCall(
            publisher: service.getEraReport(
                startEraIndex: 3200
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(1, reports?.count ?? 0)
        }
    }
    
    func test02GetMultipleEraReport() {
        testServiceCall(
            publisher: service.getEraReport(
                startEraIndex: 3201,
                endEraIndex: 3210
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(10, reports?.count ?? 0)
        }
    }
    
    func test03GetSingleEraValidatorReport() {
        testServiceCall(
            publisher: service.getEraValidatorReport(
                validatorAccountId: validatorAccountId,
                startEraIndex: 3200
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(1, reports?.count ?? 0)
        }
    }
    
    func test04GetMultipleEraValidatorReport() {
        testServiceCall(
            publisher: service.getEraValidatorReport(
                validatorAccountId: validatorAccountId,
                startEraIndex: 3275,
                endEraIndex: 3279
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(5, reports?.count ?? 0)
        }
    }
    
    static var allTests = [
        ("test01GetSingleEraReport", test01GetSingleEraReport),
        ("test02GetMultipleEraReport", test02GetMultipleEraReport),
        ("test03GetSingleEraValidatorReport", test03GetSingleEraValidatorReport),
        ("test04GetMultipleEraValidatorReport", test04GetMultipleEraValidatorReport),
    ]
}
