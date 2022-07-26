import Combine
import XCTest
@testable import SubVTData

final class NetworkStatusServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
    
    func testNetworkStatusSubscription() {
        var update: NetworkStatusUpdate? = nil
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
                    print("Finished with error.")
                    XCTFail("Finished with error: \(rpcError)")
                    finishExpectation.fulfill()
                }
            } receiveValue: { (event) in
                switch event {
                case .subscribed(_):
                    break
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
                            service.unsubscribe()
                        }
                    }
                case .unsubscribed:
                    break
                }
            }.store(in: &cancellables)
        waitForExpectations(timeout: 100)
    }
    
    static var allTests = [
        ("testNetworkStatusSubscription", testNetworkStatusSubscription),
    ]
}
