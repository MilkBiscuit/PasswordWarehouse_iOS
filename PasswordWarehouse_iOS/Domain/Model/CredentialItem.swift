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
}

struct EncryptedCredentialItem: Codable, Identifiable {
    var id: String // website
    var username: String
    var encryptedPassword: String
}
