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
    container.register(ICredentialRepository.self) { _  in
        return LocalFileCredentialRepo()
    }.inObjectScope(.container)

    return container
}
