import Combine
import XCTest
@testable import SubVTData

final class ValidatorDetailsServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
    
    func testValidatorDetailsSubscription() {
        var error: Error? = nil
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
                    break
                case .update(let validatorDetailsUpdate):
                    updateCount += 1
                    if updateCount == 1 {
                        XCTAssertNotNil(validatorDetailsUpdate.validatorDetails)
                        print("Validator details received.")
                    } else {
                        print("Validator details diff received.")
                        if updateCount == 3 {
                            service.unsubscribe()
                        }
                    }
                case .unsubscribed:
                    break
                }
            }.store(in: &cancellables)
        waitForExpectations(timeout: 100)
        XCTAssertNil(error)
    }
    
    static var allTests = [
        ("testValidatorDetailsSubscription", testValidatorDetailsSubscription),
    ]
}
