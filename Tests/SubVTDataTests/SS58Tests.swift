//
//  File.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 19.07.2022.
//

@testable import SubVTData
import XCTest

final class SS58Tests: BaseTest {
    let accountId = AccountId(hex: "0x12c0e71c4aba6d53775e0a27ff00a6090b2d9bb4171096109a5aa2a59328df61")
    
    func testGetSS58Prefix0() {
        let address = try? accountId.toSS58Check(prefix: 0)
        XCTAssertEqual(address ?? "", "1RbAdVD76ym3efALJ4GxUgSiisUjB2gVZgCn43DTPrX3864")
    }
    
    func testGetSS58Prefix2() {
        let address = try? accountId.toSS58Check(prefix: 2)
        XCTAssertEqual(address ?? "", "Czugca1sgjDMmU69MpKiHDJ1hA4qYHisSnU1RKpP73Vbiza")
    }
}
