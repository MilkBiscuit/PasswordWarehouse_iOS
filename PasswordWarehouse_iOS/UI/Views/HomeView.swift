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
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Input credentials")
                    .font(.title)
                
                Spacer().frame(height: 20)
                
                LabeledContent {
                    TextField("", text: $website)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Label("Website", systemImage: "globe")
                }
                .labeledContentStyle(.vertical)

                LabeledContent {
                    TextField("", text: $username)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                } label: {
                    Label("Username / Email", systemImage: "envelope")
                }
                .labeledContentStyle(.vertical)

                LabeledContent {
                    VisiblePasswordField("", text: $password)
                        .textFieldStyle(.roundedBorder)
                } label: {
                    Label("Password", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .labeledContentStyle(.vertical)
                Button(action: copyPasswordToClipboard) {
                    Label("Copy Password", systemImage: "doc.on.doc")
                }
                
                Spacer().frame(height: 20)

                Button(action: storeCredentials) {
                    Label("Store", systemImage: "square.and.arrow.down")
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "e.g. Amazon US"
            )
        }
    }


    private func storeCredentials() {
        
    }
    
    private func copyPasswordToClipboard() {
        UIPasteboard.general.string = self.password
    }
}

#Preview {
    HomeView()
}
