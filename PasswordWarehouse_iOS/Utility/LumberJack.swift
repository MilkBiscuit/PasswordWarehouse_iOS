//
//
// LumberJack.swift
//
// Created on 25/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

func print(_ items: Any...) {
    #if DEBUG
        Swift.print(items)
    #endif
}
