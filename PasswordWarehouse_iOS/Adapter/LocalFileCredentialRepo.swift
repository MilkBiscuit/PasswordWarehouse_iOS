//
//
// LocalFileCredentialRepo.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

class LocalFileCredentialRepo: ICredentialRepository {
    func remove(credential: CredentialItem) -> Bool {
        return false
    }
    
    func store(credential: CredentialItem) -> Bool {
        return false
    }
    
    func searchBy(website: String) -> Array<CredentialItem> {
        return Array()
    }
    
    
}
