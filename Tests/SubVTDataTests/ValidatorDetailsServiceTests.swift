import Combine
import Logging
import Starscream
import XCTest
@testable import SubVTData

final class ValidatorDetailsServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
    
    func testValidatorDetailsSubscription() {
        var error: Error? = nil
        let subscribeExpectation = self.expectation(description: "Subscribed.")
        let updateExpectation = self.expectation(description: "Validator details update received.")
        let unsubscribeExpectation = self.expectation(description: "Unsubscribed.")
        let finishExpectation = self.expectation(description: "Finished.")
        let service = ValidatorDetailsService()
        var updateCount = 0
        service
            .subscribe(parameter: "0xa00505eb2a4607f27837f57232f0c456602e39540582685b4f58cde293f1a116")
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
                case .update(let validatorDetailsUpdate):
                    updateCount += 1
                    if updateCount == 1 {
                        XCTAssertNotNil(validatorDetailsUpdate.validatorDetails)
                        print("Validator details received.")
                    } else {
                        print("Validator details diff received.")
                        if updateCount == 3 {
                            updateExpectation.fulfill()
                            service.unsubscribe()
                        }
                    }
                case .unsubscribed:
                    unsubscribeExpectation.fulfill()
                case .reconnectSuggested:
                    break
                }
            }.store(in: &cancellables)
        waitForExpectations(timeout: 60)
        XCTAssertNil(error)
    }
    
    static var allTests = [
        ("testValidatorDetailsSubscription", testValidatorDetailsSubscription),
    ]
}
