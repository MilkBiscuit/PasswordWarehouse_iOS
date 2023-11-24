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
        return credentialRepo.searchBy(website: keyword)
    }
}
