//
//
// StoreCredentialUC.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

struct StoreCredentialUC {
    @Inject
    private var credentialRepo: ICredentialRepository

    func invoke(credential: CredentialItem) -> Bool {
        return credentialRepo.store(credential: credential)
    }
}
