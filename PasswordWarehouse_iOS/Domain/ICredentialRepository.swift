//
//
// ICredentialRepository.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

protocol ICredentialRepository {
    func exportAllCredentials() async -> CipherArray?
    func importCredentials() async -> Int
    func remove(credentialId: String) async -> Bool
    func save(credential: EncryptedCredentialItem) async -> Bool
    func searchBy(website: String) -> [EncryptedCredentialItem]
}
