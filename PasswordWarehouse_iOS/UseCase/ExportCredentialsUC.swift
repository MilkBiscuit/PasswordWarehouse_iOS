//
//
// StoreCredentialUC.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct ExportCredentialsUC {
    @Inject
    private var credentialRepo: ICredentialRepository

    func invoke(masterPassword: String) async -> String? {
        guard let cipherBook = await credentialRepo.exportAllCredentials() else {
            return nil
        }
        var newCipherBook = CipherBook()
        for (key, value) in cipherBook {
            guard let clearPasswordItem = Decrypt.decrypt(
                item: value, with: SensitiveData.defaultMasterPassword
            ) else {
                print("Password does not match, export failed!")
                return nil
            }

            let encryptedItem = Encrypt.encrypt(item: clearPasswordItem, with: masterPassword)
            newCipherBook[key] = encryptedItem
        }
        do {
            let data = try JSONEncoder().encode(newCipherBook)

            return String(decoding: data, as: UTF8.self)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}
