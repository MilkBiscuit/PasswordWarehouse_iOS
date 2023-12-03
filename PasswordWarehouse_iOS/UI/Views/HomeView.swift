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
    @State private var searchText: String = ""
    @State private var generatingPassword = false
    @State private var navPath = NavigationPath()
    @Environment(\.kumaToastText) var toastText: Binding<String?>
    
    @Inject
    private var storeCredentialUC: StoreCredentialUC
    @Inject
    private var searchCredentialUC: SearchCredentialUC
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(spacing: 1) {
                Text("Input credentials")
                    .font(.title)
                
                Spacer().frame(height: 20)
                
                KumaTextField(
                    "Website", labelImage: "globe", text: $website
                )
                KumaTextField(
                    "Account Number / Email / Username", labelImage: "envelope", text: $username
                ).textInputAutocapitalization(TextInputAutocapitalization.never)
                KumaPasswordField(text: $password)
                
                // TODO: Make VStack, increase the width of Store button
                Spacer().frame(height: 20)
                Button("Generate Password") {
                    generatingPassword.toggle()
                }
                Spacer().frame(height: 20)
                Button(action: storeCredentials) {
                    Label("Store", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "e.g. Amazon US"
            )
            .onSubmit(of: .search) {
                searchCredentials()
            }
            .navigationDestination(for: CredentialList.self) { list in
                SearchResultListView(
                    credentialList: list,
                    copy: copyToClipboard
                )
            }
            .sheet(isPresented: $generatingPassword) {
                GeneratePasswordView()
            }
        }
    }

    private func copyToClipboard(_ content: String) {
        UIPasteboard.general.string = content
        toastText.wrappedValue = "Copied to clipboard"
    }
    
    private func searchCredentials() {
        let keyword = searchText
        let results = searchCredentialUC.invoke(website: keyword)
        if results.isEmpty {
            toastText.wrappedValue = "No matched results."
            return
        }
        let count = results.count
        if (count == 1) {
            website = results[0].id
            username = results[0].username
            password = results[0].passwordClearText
        } else {
            navPath.append(results)
        }
    }

    private func storeCredentials() {
        if website.isEmpty {
            toastText.wrappedValue = "Website can't be empty."
            return
        }
        if username.isEmpty && password.isEmpty {
            toastText.wrappedValue = "Username and password can't be both empty."
            return
        }
        
        storeCredentialUC.invoke(
            credential: CredentialItem(id: website, username: username, passwordClearText: password)
        )
        website = ""
        username = ""
        password = ""
    }
}


#Preview {
    HomeView()
}
