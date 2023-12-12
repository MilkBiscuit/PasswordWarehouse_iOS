//
//
// StoreCredentialUC.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct ImportCredentialsUC {
    @Inject
    private var credentialRepo: ICredentialRepository

    func invoke(fileUrl: URL, masterPassword: String) async -> Int {
        if (!fileUrl.startAccessingSecurityScopedResource()) {
            print("startAccessingSecurityScopedResource failed.")
        }
        guard let fileData = await PersistentFileHelper.readFromFile(fileUrl: fileUrl) else {
            return 0
        }
        fileUrl.stopAccessingSecurityScopedResource()
        guard let cipherArray = try? JSONDecoder().decode(CipherArray.self, from: fileData) else {
            return 0
        }
        
        for value in cipherArray {
            guard let clearPasswordItem = Decrypt.decrypt(item: value, with: masterPassword) else {
                print("The password is wrong, can not import!")

                return 0
            }
            
            let encryptedItem = Encrypt.encrypt(item: clearPasswordItem, with: SensitiveData.defaultMasterPassword)
            let _ = await credentialRepo.save(credential: encryptedItem)
        }
        print("I imported \(cipherArray.count)")
        
        return cipherArray.count
    }
}
