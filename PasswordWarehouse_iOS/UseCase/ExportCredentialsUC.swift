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
        guard let cipherArray = await credentialRepo.exportAllCredentials() else {
            return nil
        }
        var newCipherArray = CipherArray()
        for item in cipherArray {
            guard let clearPasswordItem = Decrypt.decrypt(
                item: item, with: SensitiveData.defaultMasterPassword
            ) else {
                print("Password does not match, export failed!")
                return nil
            }

            let encryptedItem = Encrypt.encrypt(item: clearPasswordItem, with: masterPassword)
            newCipherArray.append(encryptedItem)
        }
        newCipherArray = newCipherArray.sorted { $0.id < $1.id }
        do {
            let data = try JSONEncoder().encode(newCipherArray)

            return String(decoding: data, as: UTF8.self)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}
