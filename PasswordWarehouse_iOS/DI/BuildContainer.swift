//
//
// BuildContainer.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import Swinject

func buildContainer() -> Container {
    let container = Container()

    // Domain
    container.register(ICredentialRepository.self) { _  in
        return LocalFileCredentialRepo()
    }.inObjectScope(.container)
    
    // Use case
    container.register(ExportCredentialsUC.self) { _  in
        return ExportCredentialsUC()
    }.inObjectScope(.container)
    container.register(ImportCredentialsUC.self) { _  in
        return ImportCredentialsUC()
    }.inObjectScope(.container)
    container.register(StoreCredentialUC.self) { _  in
        return StoreCredentialUC()
    }.inObjectScope(.container)
    container.register(SearchCredentialUC.self) { _  in
        return SearchCredentialUC()
    }.inObjectScope(.container)

    return container
}
