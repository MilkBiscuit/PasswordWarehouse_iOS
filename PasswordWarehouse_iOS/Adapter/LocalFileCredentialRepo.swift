//
//
// LocalFileCredentialRepo.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

class LocalFileCredentialRepo: ICredentialRepository {
    
    private var cachedBook: CipherBook = [:];
    
    init() {
        Task {
            if let loadedBook = await load() {
                cachedBook = loadedBook
            } else {
                print("Load credentials failed!")
            }
        }
    }
    
    private static func fileURL() -> URL {
        return PersistentFileHelper.fileURL(fileName: "credentials.json")
    }
    
    func exportAllCredentials() async -> CipherArray? {
        if (cachedBook.isEmpty) {
            return nil
        }
        
        return cachedBook.map { $0.value }
    }
    
    func importCredentials() async -> Int {
        return 0
    }

    func remove(credentialId: String) async -> Bool {
        guard cachedBook.removeValue(forKey: credentialId) != nil
        else {
            return false
        }
        
        return await save(cipherBook: cachedBook)
    }
    
    func save(credential: EncryptedCredentialItem) async -> Bool {
        cachedBook[credential.id] = credential
        for item in cachedBook {
            print("key is \(item.key), value is \(item.value)")
        }

        return await save(cipherBook: cachedBook)
    }
    
    func searchBy(website: String) -> [EncryptedCredentialItem] {
        let matchedResults = cachedBook.filter {
            $0.key.localizedCaseInsensitiveContains(website)
        }
        return matchedResults.map { $0.value }
    }
    
    private func load() async -> CipherBook? {
        return await PersistentFileHelper.readFromFile(CipherBook.self, from: Self.fileURL())
    }
    
    private func save(cipherBook: CipherBook) async -> Bool {
        return await PersistentFileHelper.writeToFile(fileUrl: Self.fileURL(), value: cipherBook)
    }
}
