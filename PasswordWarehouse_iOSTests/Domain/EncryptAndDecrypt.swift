//
//
// EncryptAndDecrypt.swift
//
// Created on 20/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import XCTest

final class EncryptAndDecrypt: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncryptAndDecryptString() throws {
        // Given a clear text and a secret key
        let text = "Hello World"
        let secret = "123456"

        // When encrypt and decrypt with the secret key
        let cipherText = Encrypt.encryptString(message: text, with: secret)
        print("cipher text: " + cipherText)
        let decryptedText = try Decrypt.decryptString(cipherText: cipherText, with: secret)
        print("decrypted text: " + decryptedText)
        
        // Then the decrypted text is the original text
        XCTAssertEqual("Hello World", decryptedText)
    }
    
    func testEncryptAndDecryptItem() throws {
        // Given a credential item and a secret key
        let item = CredentialItem(id: "Facebook", username: "abc@hotmail.com", passwordClearText: "SuMiCM+JD0zP")
        let secret = "123456"
        let encryptedItem = Encrypt.encrypt(item: item, with: secret)
        let decryptedItem = Decrypt.decrypt(item: encryptedItem, with: secret)
        print("encrypted password: " + encryptedItem.encryptedPassword)
        
        // Then the decrypted password is correct
        XCTAssertNotNil(decryptedItem)
        XCTAssertEqual("SuMiCM+JD0zP", decryptedItem!.passwordClearText)
    }

}
