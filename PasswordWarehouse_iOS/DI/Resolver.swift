//
//
// Resolver.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

class Resolver {
    static let shared = Resolver()
    
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
