import Combine
import XCTest
@testable import SubVTData

final class ValidatorListServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        initLog()
        cancellables = []
    }
    
    private func validatorListSubscriptionTest(active: Bool) {
        var error: Error? = nil
        let subscribeExpectation = self.expectation(description: "Subscribed.")
        let updateExpectation = self.expectation(description: "Validator list updates received.")
        let unsubscribeExpectation = self.expectation(description: "Unsubscribed.")
        let finishExpectation = self.expectation(description: "Finished.")
        let service = ValidatorListService(active: active)
        var updateCount = 0
        service
            .subscribe()
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Finished.")
                    finishExpectation.fulfill()
                case .failure(let rpcError):
                    print("Finished with error: \(rpcError)")
                    error = rpcError
                    finishExpectation.fulfill()
                }
            } receiveValue: { (event) in
                switch event {
                case .subscribed(_):
                    subscribeExpectation.fulfill()
                case .update(let listUpdate):
                    updateCount += 1
                    if updateCount == 1 {
                        XCTAssertTrue(listUpdate.insert.count > 0)
                        XCTAssertEqual(0, listUpdate.update.count)
                        XCTAssertEqual(0, listUpdate.removeIds.count)
                        print("Initial list received.")
                    } else {
                        print("List diff received.")
                        if updateCount == 3 {
                            updateExpectation.fulfill()
                            service.unsubscribe()
                        }
                    }
                case .unsubscribed:
                    unsubscribeExpectation.fulfill()
                }
            }.store(in: &cancellables)
        waitForExpectations(timeout: 60 * 3)
        XCTAssertNil(error)
    }
    
    func testActiveValidatorListSubscription() {
        validatorListSubscriptionTest(active: true)
    }
    
    func testInactiveValidatorListSubscription() {
        validatorListSubscriptionTest(active: false)
    }
    
    static var allTests = [
        ("testActiveValidatorListSubscription", testActiveValidatorListSubscription),
    ]
}
