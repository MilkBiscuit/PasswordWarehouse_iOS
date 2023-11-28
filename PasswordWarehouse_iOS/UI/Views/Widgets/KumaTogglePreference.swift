//
//
// KumaTogglePreference.swift
//
// Created on 26/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct KumaTogglePreference: View {
    var isToggleOn: Binding<Bool>
    var text: String
    var description: String?
    
    var body: some View {
        Toggle(isOn: isToggleOn) {
            Text(text)
                .font(.title3)
            if let descriptionText = description {
                Text(descriptionText)
                    .font(.caption)
            }
        }
            .controlSize(.large)
    }
}

#Preview {
    List {
        KumaPreferenceItem(
            text: "Email preferences",
            clickAction: {}
        )
        KumaTogglePreference(
            isToggleOn: .constant(true),
            text: "Face ID", description: "Use Face ID when launching Password Bin"
        )
    }
    .listStyle(.grouped)
}
