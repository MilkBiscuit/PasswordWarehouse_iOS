//
//
// Inject.swift
//
// Created on 24/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}
