import Combine
import XCTest
@testable import SubVTData

final class ValidatorDetailsServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        initLog()
        cancellables = []
    }
    
    func testValidatorDetailsSubscription() {
        var error: Error? = nil
        let finishExpectation = self.expectation(description: "Finished.")
        let service = ValidatorDetailsService()
        var updateCount = 0
        service
            .subscribe(parameter: "0xA00505EB2A4607F27837F57232F0C456602E39540582685B4F58CDE293F1A116")
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
        waitForExpectations(timeout: 60 * 3)
        XCTAssertNil(error)
    }
    
    static var allTests = [
        ("testValidatorDetailsSubscription", testValidatorDetailsSubscription),
    ]
}
