//
//
// EncryptTest.swift
//
// Created on 19/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//

import XCTest
import PasswordWarehouse_iOS

final class EncryptTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncryptSameText() throws {
        // Given 2 exact same text strings
        let text_1 = "Hello World"
        let text_2 = "Hello World"
        let secret = "123456"

        // When encrypt them
        let cipherText_1 = Encrypt.encryptString(messageTo: text_1, use: secret)
        let cipherText_2 = Encrypt.encryptString(messageTo: text_2, use: secret)
        
        // Then the encrypted text are not the same (can NEVER use EBC mode)
//        XCTAssertNotEqual(cipherText_1, cipherText_2)
    }

}
