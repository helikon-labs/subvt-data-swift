import Combine
import Starscream
import XCTest
@testable import SubVTData

final class NetworkStatusServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
    
    func testNetworkStatusSubscription() {
        var error: Error? = nil
        var update: NetworkStatusUpdate? = nil
        let subscribeExpectation = self.expectation(description: "Subscribed.")
        let updateExpectation = self.expectation(description: "Network status updates received.")
        let unsubscribeExpectation = self.expectation(description: "Unsubscribed.")
        let finishExpectation = self.expectation(description: "Finished.")
        let service = NetworkStatusService()
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
                case .update(let statusUpdate):
                    update = statusUpdate
                    updateCount += 1
                    if updateCount == 1 {
                        XCTAssertNotNil(update?.status)
                        print("Status received.")
                    } else {
                        XCTAssertNotNil(update?.diff)
                        print("Status diff received.")
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
        waitForExpectations(timeout: 100)
        XCTAssertNil(error)
    }
    
    static var allTests = [
        ("testNetworkStatusSubscription", testNetworkStatusSubscription),
    ]
}
