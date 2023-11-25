//
//
// CredentialItem.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct CredentialItem: Codable, Hashable, Identifiable {
    var id: String // website
    var username: String
    var passwordClearText: String
    
    public func encrypt() -> EncryptedCredentialItem {
        return EncryptedCredentialItem(
            id: id, username: username, encryptedPassword: passwordClearText
        );
    }
}

struct EncryptedCredentialItem: Codable, Identifiable {
    var id: String // website
    var username: String
    var encryptedPassword: String
    
    public func decrypt() -> CredentialItem {
        return CredentialItem(
            id: id, username: username, passwordClearText: encryptedPassword
        );
    }
}
