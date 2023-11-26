//
//
// KumaItemWithArrow.swift
//
// Created on 26/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct KumaPreferenceItem: View {

    private let leadingIconSize: CGFloat = 44
    private let trailingItemSize: CGFloat = 44
    var text: String
    var description: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.title3)
                if let descriptionText = description {
                    Text(descriptionText)
                        .font(.caption)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.lightGray)
                .frame(width: trailingItemSize)
        }
    }
}

#Preview {
    List {
        KumaPreferenceItem(
            text: "Notifications", description: "Enabled (Receiving 20 types)"
        )
        KumaPreferenceItem(
            text: "Search history", description: "Recent searches saved"
        )
    }
    .listStyle(.grouped)
}
