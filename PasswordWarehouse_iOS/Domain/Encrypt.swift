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

    static func encryptString(message: String, use password: String) -> String {
        // TODO, use password to generate an encryption key
        let messageData: Data = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: password)

        return cipherData.base64EncodedString()
    }
    
}
