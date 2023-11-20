//
//
// Decrypt.swift
//
// Created on 19/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import RNCryptor

class Decrypt {

    static func decryptString(cipherText: String, use password: String) throws -> String {
        let encryptedData = Data.init(base64Encoded: cipherText)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: password)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }

}
