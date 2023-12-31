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

    func testEncryptSameTextWithSameKey() throws {
        // Given exact same text string and secret
        let text = "Hello World"
        let secret = "123456"

        // When encrypt the string twice
        let cipherText_1 = Encrypt.encryptString(message: text, with: secret)
        let cipherText_2 = Encrypt.encryptString(message: text, with: secret)
        print("cipher text 1: " + cipherText_1)
        print("cipher text 2: " + cipherText_2)
        
        // Then the encrypted text are not the same (can NEVER use EBC mode)
        XCTAssertNotEqual(cipherText_1, cipherText_2)
    }

}
