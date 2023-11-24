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
    @State private var toast: Toast? = nil
    
    @Inject
    private var storeCredentialUC: StoreCredentialUC
    
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                Text("Input credentials")
                    .font(.title)
                
                Spacer().frame(height: 20)
                
                KumaTextField(
                    "Website", labelImage: "globe", text: $website
                )
                KumaTextField(
                    "Username / Email", labelImage: "envelope", text: $username
                ).textInputAutocapitalization(TextInputAutocapitalization.never)
                KumaPasswordField(text: $password, copy: copyPasswordToClipboard)
                
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
        .toastView(toast: $toast)
    }


    private func storeCredentials() {
        storeCredentialUC.invoke(
            credential: CredentialItem(id: website, username: username, passwordClearText: password)
        )
    }
    
    private func copyPasswordToClipboard() {
        UIPasteboard.general.string = self.password
        // TODO: Add the password len into the toast
        toast = Toast(message: "Copied password to clipboard")
    }
}

#Preview {
    HomeView()
}
