//
//
// StoreCredentialUC.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct SearchCredentialUC {
    @Inject
    private var credentialRepo: ICredentialRepository

    func invoke(website keyword: String) -> [CredentialItem] {
        return credentialRepo.searchBy(website: keyword).map {
            guard let decrypted = Decrypt.decrypt(
                item: $0, with: SensitiveData.defaultMasterPassword
            ) else {
                fatalError("Something terribly wrong, failed to decrypt!")
            }

            return decrypted
        }
    }
}
