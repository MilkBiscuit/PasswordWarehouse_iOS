//
//
// EncryptTest.swift
//
// Created on 19/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//

import XCTest
import PasswordWarehouse_iOS

final class DecryptTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecryptString() throws {
        // Given this cipher text was encrypted with "123456"
        let cipherText = "AwF2PySPjb5L4Ye7DqGwdz6T3f5/OzCjM/B5zrRmXsoE9LnW9keHNYiyhTOGbnKDatPWYSSWDLqKAI64rIPqIg+ATfzH1wyR7FG41tithzPxgg=="
        // When decrypt it with correct secret
        let clearPassword = try Decrypt.decryptString(cipherText: cipherText, with: "123456")
        print("clear password: \(clearPassword)")
        // Then decryption is successful
        XCTAssertEqual("Hello World", clearPassword)
    }

}
