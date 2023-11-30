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

    func invoke() async -> String? {
        return await credentialRepo.exportAllCredentials()
    }
}
