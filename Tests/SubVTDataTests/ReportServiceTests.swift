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
                startEraIndex: 3391
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(1, reports?.count ?? 0)
            let report = reports![0]
            XCTAssertTrue(report.activeValidatorCount > 0)
            XCTAssertTrue(report.inactiveValidatorCount > 0)
        }
    }
    
    func test02GetMultipleEraReport() {
        testServiceCall(
            publisher: service.getEraReport(
                startEraIndex: 3391,
                endEraIndex: 3400
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
                startEraIndex: 3391
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
                startEraIndex: 3391,
                endEraIndex: 3400
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(10, reports?.count ?? 0)
        }
    }
    
    func test05GetValidatorSummaryReport() {
        testServiceCall(
            publisher: service.getValidatorSummaryReport(
                validatorAccountId: validatorAccountId
            )
        ) {
            [weak self]
            (report, error) in
            guard let self = self else { return }
            XCTAssertNil(error)
            XCTAssertEqual(report?.validatorSummary.accountId, self.validatorAccountId)
        }
    }
    
    func test05GetValidatorDetailsReport() {
        testServiceCall(
            publisher: service.getValidatorDetailsReport(
                validatorAccountId: validatorAccountId
            )
        ) {
            [weak self]
            (report, error) in
            guard let self = self else { return }
            XCTAssertNil(error)
            XCTAssertEqual(report?.validatorDetails.account.id, self.validatorAccountId)
        }
    }
    
    func test06GetValidatorListReport() {
        testServiceCall(
            publisher: service.getValidatorListReport()
        ) {
            (report, error) in
            XCTAssertNil(error)
            XCTAssertTrue(report?.validators.count ?? 0 > 0)
        }
    }
    
    func test07GetActiveValidatorListReport() {
        testServiceCall(
            publisher: service.getActiveValidatorListReport()
        ) {
            (report, error) in
            XCTAssertNil(error)
            XCTAssertTrue(report?.validators.count ?? 0 > 0)
        }
    }
    
    func test08GetInactiveValidatorListReport() {
        testServiceCall(
            publisher: service.getInactiveValidatorListReport()
        ) {
            (report, error) in
            XCTAssertNil(error)
            XCTAssertTrue(report?.validators.count ?? 0 > 0)
        }
    }
    
    func test09SearchValidators() {
        testServiceCall(
            publisher: service.searchValidators(query: "heli")
        ) {
            (report, error) in
            XCTAssertNil(error)
            XCTAssertTrue(report?.count ?? 0 > 0)
        }
    }
    
    func test10GetOneKVNominatorSummaries() {
        testServiceCall(
            publisher: service.getOneKVNominatorSummaries()
        ) {
            (report, error) in
            XCTAssertNil(error)
            XCTAssertTrue(report?.count ?? 0 > 0)
        }
    }
    
    func test10GetCurrentEra() {
        testServiceCall(
            publisher: service.getCurrentEra()
        ) {
            (era, error) in
            XCTAssertNil(error)
            XCTAssertTrue(era?.index ?? 0 > 0)
        }
    }
    
    func test11GetCurrentEra() {
        testServiceCall(
            publisher: service.getCurrentEra()
        ) {
            (session, error) in
            XCTAssertNil(error)
        }
    }
    
    func test12GetAllEras() {
        testServiceCall(
            publisher: service.getAllEras()
        ) {
            (eras, error) in
            XCTAssertNil(error)
            XCTAssertTrue(eras?.count ?? 0 > 0)
        }
    }
    
    func test13GetValidatorEraRewardReport() {
        testServiceCall(
            publisher: service.getValidatorEraRewardReport(validatorAccountId: validatorAccountId)
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertTrue(reports?.count ?? 0 > 0)
        }
    }
    
    func test14GetValidatorEraPayoutReport() {
        testServiceCall(
            publisher: service.getValidatorEraPayoutReport(validatorAccountId: validatorAccountId)
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertTrue(reports?.count ?? 0 > 0)
        }
    }
    
    func test15GetSingleSessionValidatorReport() {
        testServiceCall(
            publisher: service.getSessionValidatorReport(
                validatorAccountId: validatorAccountId,
                startSessionIndex: 39931
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(1, reports?.count ?? 0)
            let report = reports![0]
            XCTAssertNotNil(report.paraVotesSummary)
            XCTAssertNil(report.heartbeatEvent)
        }
    }
    
    func test16GetMultipleSessionValidatorReport() {
        testServiceCall(
            publisher: service.getSessionValidatorReport(
                validatorAccountId: validatorAccountId,
                startSessionIndex: 39950,
                endSessionIndex: 39959
            )
        ) {
            (reports, error) in
            XCTAssertNil(error)
            XCTAssertEqual(10, reports?.count ?? 0)
        }
    }
    
    func test17GetCurrentSession() {
        testServiceCall(
            publisher: service.getCurrentSession()
        ) {
            (session, error) in
            XCTAssertNil(error)
        }
    }
    
    func test18GetNetworkStatus() {
        testServiceCall(
            publisher: service.getNetworkStatus()
        ) {
            (networkStatus, error) in
            XCTAssertNil(error)
        }
    }
    
    func test19GetMonthlyIncome() {
        testServiceCall(
            publisher: service.getMonthlyIncomeReport(
                rewardeeAccountId: validatorAccountId
            )
        ) {
            (report, error) in
            print("\(report!.monthlyIncome[0].income)")
            XCTAssertNil(error)
        }
    }
    
    static var allTests = [
        ("test01GetSingleEraReport", test01GetSingleEraReport),
        ("test02GetMultipleEraReport", test02GetMultipleEraReport),
        ("test03GetSingleEraValidatorReport", test03GetSingleEraValidatorReport),
        ("test04GetMultipleEraValidatorReport", test04GetMultipleEraValidatorReport),
        ("test05GetValidatorDetailsReport", test05GetValidatorDetailsReport),
        ("test06GetValidatorListReport", test06GetValidatorListReport),
        ("test07GetActiveValidatorListReport", test07GetActiveValidatorListReport),
        ("test08GetInactiveValidatorListReport", test08GetInactiveValidatorListReport),
        ("test09SearchValidators", test09SearchValidators),
        ("test10GetOneKVNominatorSummaries", test10GetOneKVNominatorSummaries),
        ("test11GetCurrentEra", test11GetCurrentEra),
        ("test12GetAllEras", test12GetAllEras),
        ("test13GetValidatorEraRewardReport", test13GetValidatorEraRewardReport),
        ("test14GetValidatorEraPayoutReport", test14GetValidatorEraPayoutReport),
        ("test15GetSingleSessionValidatorReport", test15GetSingleSessionValidatorReport),
        ("test16GetMultipleSessionValidatorReport", test16GetMultipleSessionValidatorReport),
        ("test17GetCurrentSession", test17GetCurrentSession),
        ("test18GetNetworkStatus", test18GetNetworkStatus),
        ("test19GetMonthlyIncome", test19GetMonthlyIncome),
    ]
}
