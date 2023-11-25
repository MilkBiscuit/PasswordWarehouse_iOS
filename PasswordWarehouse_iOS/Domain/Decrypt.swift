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
    
    static func decrypt(item: EncryptedCredentialItem, with password: String) -> CredentialItem? {
        guard let password = try? decryptString(
            cipherText: item.encryptedPassword, with: password
        ) else {
            return nil
        }

        return CredentialItem(id: item.id, username: item.username, passwordClearText: password)
    }

    static func decryptString(cipherText: String, with password: String) throws -> String {
        let encryptedData = Data.init(base64Encoded: cipherText)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: password)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }

}
