import Combine
import XCTest
@testable import SubVTData

fileprivate let validatorAccountId = AccountId(
    hex: "0xa00505eb2a4607f27837f57232f0c456602e39540582685b4f58cde293f1a116"
)
fileprivate let service = AppService()

final class AppServiceTests: BaseTest {
    private static var user: User!
    
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
    
    func test03GetNotificationTypes() {
        testServiceCall(publisher: service.getNotificationTypes()) {
            (types, error) in
            XCTAssertNil(error)
            XCTAssertTrue(types?.count ?? 0 > 0)
        }
    }
    
    func test04CreateUser() {
        KeychainStorage.shared.clear()
        testServiceCall(publisher: service.createUser()){
            (user, error) in
            XCTAssertNil(error)
            XCTAssertTrue(user?.id ?? 0 > 0)
            AppServiceTests.user = user
        }
    }
    
    func test05GetUserNotificationChannels() {
        testServiceCall(publisher: service.getUserNotificationChannels()) {
            (channels, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, channels?.count)
        }
    }
    
    func test06CreateUserNotificationChannel() {
        let channel = NewUserNotificationChannel(
            channelCode: .email,
            target: "test@test.org"
        )
        testServiceCall(
            publisher: service.createUserNotificationChannel(
                channel: channel
            )
        ) {
            (channel, error) in
            XCTAssertNil(error)
            XCTAssertTrue(channel?.id ?? 0 > 0)
            XCTAssertEqual(AppServiceTests.user.id, channel!.userId)
        }
    }
    
    func test07DeleteUserNotificationChannel() {
        let publisher = service
            .getUserNotificationChannels()
            .flatMap {
                (response) -> ServiceResponsePublisher<EmptyResponse> in
                let channel = response.value?[0]
                XCTAssertNotNil(channel)
                return service.deleteUserNotificationChannel(id: channel!.id)
            }
            .eraseToAnyPublisher()
            .flatMap {
                (response) -> ServiceResponsePublisher<[UserNotificationChannel]> in
                return service.getUserNotificationChannels()
            }
            .eraseToAnyPublisher()
        testServiceCall(publisher: publisher) {
            (channels, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, channels?.count)
        }
    }
    
    func test08DeleteNonExistingUserNotificationChannel() {
        testServiceCall(
            publisher: service.deleteUserNotificationChannel(id: 17463)
        ) {
            (_, error) in
            XCTAssertNotNil(error?.backendError)
        }
    }
    
    func test09GetUserValidators() {
        testServiceCall(publisher: service.getUserValidators()) {
            (validators, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, validators?.count)
        }
    }
    
    func test10CreateUserValidator() {
        let publisher = service
            .getNetworks()
            .flatMap {
                (response) -> ServiceResponsePublisher<UserValidator> in
                let network = response.value?[0]
                XCTAssertNotNil(network)
                let validator = NewUserValidator(
                    networkId: network!.id,
                    validatorAccountId: validatorAccountId
                )
                return service.createUserValidator(validator: validator)
            }
            .eraseToAnyPublisher()
        testServiceCall(
            publisher: publisher
        ) {
            (validator, error) in
            XCTAssertNil(error)
            XCTAssertTrue(validator?.id ?? 0 > 0)
            XCTAssertEqual(AppServiceTests.user.id, validator!.userId)
        }
    }
    
    func test11DeleteUserValidator() {
        let publisher = service
            .getUserValidators()
            .flatMap {
                (response) -> ServiceResponsePublisher<EmptyResponse> in
                let validator = response.value?[0]
                XCTAssertNotNil(validator)
                return service.deleteUserValidator(id: validator!.id)
            }
            .eraseToAnyPublisher()
            .flatMap {
                (response) -> ServiceResponsePublisher<[UserValidator]> in
                return service.getUserValidators()
            }
            .eraseToAnyPublisher()
        testServiceCall(publisher: publisher) {
            (validators, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, validators?.count)
        }
    }
    
    func test12DeleteNonExistingUserValidator() {
        testServiceCall(
            publisher: service.deleteUserValidator(id: 17463)
        ) {
            (_, error) in
            XCTAssertNotNil(error?.backendError)
        }
    }
    
    func test13GetUserNotificationRules() {
        testServiceCall(publisher: service.getUserNotificationRules()) {
            (rules, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, rules?.count)
        }
    }
    
    func test14CreateUserNotificationRule() {
        var channelId: UInt64 = 0
        let channel = NewUserNotificationChannel(
            channelCode: .gsm,
            target: "+905321234567"
        )
        let publisher = service
            .createUserNotificationChannel(channel: channel)
            .flatMap {
                (response) -> ServiceResponsePublisher<[NotificationType]> in
                XCTAssertNotNil(response.value)
                channelId = response.value!.id
                return service.getNotificationTypes()
            }
            .eraseToAnyPublisher()
            .flatMap {
                (response) -> ServiceResponsePublisher<UserNotificationRule> in
                XCTAssertNotNil(response.value)
                let notificationType = response.value!.filter {
                    $0.code == "chain_validator_new_nomination"
                }[0]
                let request = CreateUserNotificationRuleRequest(
                    notificationTypeCode: notificationType.code,
                    name: "Some notification name",
                    networkId: nil,
                    isForAllValidators: true,
                    userValidatorIds: [],
                    periodType: .immediate,
                    period: 0,
                    userNotificationChannelIds: [channelId],
                    parameters: [
                        NewUserNotificationRuleParameter(
                            parameterTypeId: notificationType.paramTypes[0].id,
                            value: "12345"
                        )
                    ],
                    notes: "Notes"
                )
                return service.createUserNotificationRule(request: request)
            }
            .eraseToAnyPublisher()
        testServiceCall(
            publisher: publisher
        ) {
            (rule, error) in
            XCTAssertNotNil(rule)
            XCTAssertTrue(rule?.id ?? 0 > 0)
            XCTAssertEqual(AppServiceTests.user.id, rule!.userId)
            XCTAssertEqual(1, rule!.parameters.count)
        }
    }
    
    func test15DeleteUserNotificationRule() {
        let publisher = service
            .getUserNotificationRules()
            .flatMap {
                (response) -> ServiceResponsePublisher<EmptyResponse> in
                let rule = response.value?[0]
                XCTAssertNotNil(rule)
                return service.deleteUserNotificationRule(id: rule!.id)
            }
            .eraseToAnyPublisher()
            .flatMap {
                (response) -> ServiceResponsePublisher<[UserNotificationRule]> in
                return service.getUserNotificationRules()
            }
            .eraseToAnyPublisher()
        testServiceCall(publisher: publisher) {
            (rules, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0, rules?.count)
        }
    }
    
    func test16DeleteNonExistingUserNotificationRule() {
        testServiceCall(
            publisher: service.deleteUserNotificationRule(id: 17463)
        ) {
            (_, error) in
            XCTAssertNotNil(error?.backendError)
        }
    }
    
    static var allTests = [
        ("test01GetNetworks", test01GetNetworks),
        ("test02GetNotificationChannels", test02GetNotificationChannels),
        ("test03GetNotificationTypes", test03GetNotificationTypes),
        ("test04CreateUser", test04CreateUser),
        ("test05GetUserNotificationChannels", test05GetUserNotificationChannels),
        ("test06CreateUserNotificationChannel", test06CreateUserNotificationChannel),
        ("test07DeleteUserNotificationChannel", test07DeleteUserNotificationChannel),
        ("test08DeleteNonExistingUserNotificationChannel", test08DeleteNonExistingUserNotificationChannel),
        ("test09GetUserValidators", test09GetUserValidators),
        ("test10CreateUserValidator", test10CreateUserValidator),
        ("test11DeleteUserValidator", test11DeleteUserValidator),
        ("test12DeleteNonExistingUserValidator", test12DeleteNonExistingUserValidator),
        ("test13GetUserNotificationRules", test13GetUserNotificationRules),
        ("test14CreateUserNotificationRule", test14CreateUserNotificationRule),
        ("test15DeleteUserNotificationRule", test15DeleteUserNotificationRule),
        ("test16DeleteNonExistingUserNotificationRule", test16DeleteNonExistingUserNotificationRule),
    ]
}
