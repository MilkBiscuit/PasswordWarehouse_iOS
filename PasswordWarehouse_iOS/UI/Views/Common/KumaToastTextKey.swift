//
//
// KumaToastTextKey.swift
//
// Created on 3/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import SwiftUI

struct KumaToastTextKey: EnvironmentKey {
    static var defaultValue: Binding<String?> = .constant(nil)
}

extension EnvironmentValues {
  var kumaToastText: Binding<String?> {
    get { self[KumaToastTextKey.self] }
    set { self[KumaToastTextKey.self] = newValue }
  }
}
