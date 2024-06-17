//
//  ModelTests.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 31.07.2022.
//

import Foundation
@testable import SubVTData
import XCTest

final class Model: XCTestCase {
    
    override func setUp() {
        initLog()
    }
    
    func testBalanceAdd() {
        XCTAssertEqual(
            Balance(integerLiteral: 123) + Balance(integerLiteral: 345),
            Balance(integerLiteral: 468)
        )
    }
    
    func testBalanceSubtract() {
        XCTAssertEqual(
            Balance(integerLiteral: 123) - Balance(integerLiteral: 100),
            Balance(integerLiteral: 23)
        )
    }
    
    func testBalanceMultiply() {
        XCTAssertEqual(
            Balance(integerLiteral: 74854) * Balance(integerLiteral: 3245),
            Balance(integerLiteral: 242901230)
        )
    }
    
    func testBalanceDivide() {
        XCTAssertEqual(
            Balance(integerLiteral: 74854) / Balance(integerLiteral: 3245),
            Balance(integerLiteral: 23)
        )
    }
    
    func testBalanceMod() {
        XCTAssertEqual(
            Balance(integerLiteral: 74854) % Balance(integerLiteral: 3245),
            Balance(integerLiteral: 219)
        )
    }
}
