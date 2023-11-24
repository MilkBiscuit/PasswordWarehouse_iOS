//
//
// CredentialItem.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct CredentialItem {
    var website: String
    var username: String
    var passwordClearText: String
    
    public func encrypt() -> EncryptedCredentialItem {
        return EncryptedCredentialItem(
            website: website, username: username, encryptedPassword: ""
        );
    }
}

struct EncryptedCredentialItem {
    var website: String
    var username: String
    var encryptedPassword: String
    
    public func decrypt() -> CredentialItem {
        return CredentialItem(
            website: website, username: username, passwordClearText: ""
        );
    }
}
