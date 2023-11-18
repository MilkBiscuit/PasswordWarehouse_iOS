//
//  HomeView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var website: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            LabeledContent {
                TextField("", text: $website)
                    .textFieldStyle(.roundedBorder)
            } label: {
                Label("Website", systemImage: "hammer")
            }
            .labeledContentStyle(.vertical)

            LabeledContent {
                TextField("", text: $username)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
            } label: {
                Label("Username (email)", systemImage: "hammer")
            }
            .labeledContentStyle(.vertical)

            LabeledContent {
                TextField("", text: $password)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
            } label: {
                Label("Password", systemImage: "hammer")
            }
            .labeledContentStyle(.vertical)
            
            Spacer()
            
            Button(action: {}) {
                Label("Store", systemImage: "square.and.arrow.down")
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
