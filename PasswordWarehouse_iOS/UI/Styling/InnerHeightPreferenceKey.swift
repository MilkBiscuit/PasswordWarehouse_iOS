//
//
// InnerHeightPreferenceKey.swift
//
// Created on 3/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
