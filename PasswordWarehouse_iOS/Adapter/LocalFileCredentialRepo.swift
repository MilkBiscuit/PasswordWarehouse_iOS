//
//
// LocalFileCredentialRepo.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

typealias CipherBook = [String: EncryptedCredentialItem]

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
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("credentials.json")
    }

    func remove(credential: CredentialItem) async -> Bool {
        guard cachedBook.removeValue(forKey: credential.id) != nil
        else {
            return false
        }
        
        return await save(cipherBook: cachedBook)
    }
    
    func save(credential: CredentialItem) async -> Bool {
        let encryptedItem = credential.encrypt()
        cachedBook[credential.id] = encryptedItem
        for item in cachedBook {
            print("key is \(item.key), value is \(item.value)")
        }

        return await save(cipherBook: cachedBook)
    }
    
    func searchBy(website: String) -> [CredentialItem] {
        let matchedResults = cachedBook.filter { $0.key.localizedCaseInsensitiveContains(website) }
        let encryptedItems = matchedResults.map { $0.value }

        return encryptedItems.map { $0.decrypt() }
    }
    
    private func load() async -> CipherBook? {
        let task = Task<[String: EncryptedCredentialItem], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return [:]
            }

            return try JSONDecoder().decode(CipherBook.self, from: data)
        }

        do {
            return try await task.value
        } catch {
            return nil
        }
    }
    
    private func save(cipherBook: CipherBook) async -> Bool {
        let task = Task {
            let data = try JSONEncoder().encode(cipherBook)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        do {
            _ = try await task.value
            
            return true
        } catch {
            print(error.localizedDescription)
            
            return false
        }
    }
}
