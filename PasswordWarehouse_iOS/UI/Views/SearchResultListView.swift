//
//
// SearchResultListView.swift
//
// Created on 25/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import SwiftUI

typealias CredentialList = [CredentialItem]

struct SearchResultListView: View {
    var credentialList: CredentialList
    
    var body: some View {
        List {
            ForEach(credentialList) { item in
                Section (header: Text(item.id)) {
                    VStack(alignment: .leading, content: {
                        Text(item.username)
                        Text(item.passwordClearText)
                    })
                }
            }
        }
    }
}

#Preview {
    SearchResultListView(
        credentialList: [
            CredentialItem(id: "Amazon AU", username: "abc@gmail.com", passwordClearText: "123456"),
            CredentialItem(id: "Amazon CN", username: "abc@hotmail.com", passwordClearText: "123456"),
            CredentialItem(id: "Amazon US", username: "123@gmail.com", passwordClearText: "123456"),
        ]
    )
}
