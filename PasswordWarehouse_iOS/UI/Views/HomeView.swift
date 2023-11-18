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
                    Label("Username (email)", systemImage: "envelope")
                }
                .labeledContentStyle(.vertical)

                LabeledContent {
                    TextField("", text: $password)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                } label: {
                    Label("Password", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .labeledContentStyle(.vertical)
                
                Spacer().frame(height: 20)
                
                Button(action: {}) {
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
}

#Preview {
    HomeView()
}
