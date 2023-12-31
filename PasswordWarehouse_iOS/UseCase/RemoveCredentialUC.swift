//
//
// StoreCredentialUC.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct RemoveCredentialUC {
    @Inject
    private var credentialRepo: ICredentialRepository

    func invoke(website: String) async -> Bool {
        return await credentialRepo.remove(credentialId: website)
    }
}
