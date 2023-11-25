//
//
// Encrypt.swift
//
// Created on 19/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import RNCryptor

class Encrypt {
    
    static func encrypt(item: CredentialItem, with password: String) -> EncryptedCredentialItem {
        let encryptedPasword = encryptString(message: item.passwordClearText, with: password)
        
        return EncryptedCredentialItem(
            id: item.id,
            username: item.username,
            encryptedPassword: encryptedPasword
        )
    }

    static func encryptString(message: String, with password: String) -> String {
        // TODO, use password to generate an encryption key
        let messageData: Data = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: password)

        return cipherData.base64EncodedString()
    }
    
}
