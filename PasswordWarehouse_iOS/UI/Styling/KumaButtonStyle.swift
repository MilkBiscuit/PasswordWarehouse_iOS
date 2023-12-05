//
//
// KumaButtonStyle.swift
//
// Created on 5/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import SwiftUI

// Ugly, do not use
struct KumaButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding([.horizontal], 8)
            .padding([.vertical], 4)
            .foregroundColor(.primary)
            .background(configuration.isPressed ? Color.transparentBlack20 : Color.transparent)
            .cornerRadius(8.0)
    }

}
