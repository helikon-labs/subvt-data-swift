import Combine
import XCTest
@testable import SubVTData

final class AppServiceTests: BaseTest {
    private let service = AppService()
    private var user: User!
    
    func test01GetNetworks() {
        testServiceCall(publisher: service.getNetworks()) {
            (networks, error) in
            XCTAssertNil(error)
            XCTAssertTrue(networks?.count ?? 0 > 0)
        }
    }
    
    func test02GetNotificationChannels() {
        testServiceCall(publisher: service.getNotificationChannels()) {
            (channels, error) in
            XCTAssertNil(error)
            XCTAssertEqual(6, channels?.count ?? 0)
        }
    }
    
    func test04CreateUser() {
        KeychainStorage.shared.clear()
        testServiceCall(publisher: service.createUser()){
            [weak self]
            (user, error) in
            guard let self = self else { return }
            XCTAssertNil(error)
            XCTAssertTrue(user?.id ?? 0 > 0)
            self.user = user
        }
    }
    
    func test05Dada() {
        print("AFTER")
    }
    
    static var allTests = [
        ("test01GetNetworks", test01GetNetworks),
        ("test02GetNotificationChannels", test02GetNotificationChannels),
        ("test04CreateUser", test04CreateUser),
    ]
}
