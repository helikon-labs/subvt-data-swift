import Combine
import XCTest
@testable import SubVTData

final class AppServiceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private let service = AppService()
    private var user: User!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test04CreateUser() {
        KeychainStorage.shared.clear()
        let expectation = self.expectation(description: "Create user request.")
        var error: APIError? = nil
        service.createUser()
            .sink { [weak self] (response) in
                if response.error != nil {
                    error = response.error
                } else {
                    self?.user = response.value!
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5)
        XCTAssertNil(error)
        XCTAssertNotNil(user)
    }
    
    func test05Dada() {
        print("AFTER")
    }
    
    static var allTests = [
        ("test04CreateUser", test04CreateUser),
    ]
}
