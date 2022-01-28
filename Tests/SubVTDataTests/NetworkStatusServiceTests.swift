import Combine
import Starscream
import XCTest
@testable import SubVTData

final class NetworkStatusServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        cancellables = []
    }
    
    func testGetNetworkStatus() {
        var error: Error? = nil
        var update: NetworkStatusUpdate? = nil
        let expectation = self.expectation(description: "")
        let service = RPCSubscriptionService<NetworkStatusUpdate>(
            host: Settings.shared.apiHost,
            port: Settings.shared.networkStatusServicePort,
            subscribeMethod: "subscribe_networkStatus",
            unsubscribeMethod: "unsubscribe_networkStatus"
        )
        service
            .subscribe()
            .sink { (completion) in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let rpcError):
                    error = rpcError
                    expectation.fulfill()
                }
            } receiveValue: { (event) in
                switch event {
                case .update(let statusUpdate):
                    update = statusUpdate
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssertNotNil(update)
    }
    
    static var allTests = [
        ("testGetNetworkStatus", testGetNetworkStatus),
    ]
}
