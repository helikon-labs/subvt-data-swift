import Combine
import Logging
import XCTest
@testable import SubVTData

class BaseTest: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
 
    func testServiceCall<T>(
        publisher: ServiceResponsePublisher<T>,
        timeoutSec: Double = 5,
        afterCall: ((T?, APIError?) -> ())? = nil
    ) {
        let expectation = self.expectation(description: "")
        var error: APIError? = nil
        var value: T? = nil
        publisher
            .sink { (response) in
                if response.error != nil {
                    error = response.error
                } else {
                    value = response.value!
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: timeoutSec)
        afterCall?(value, error)
    }
}
