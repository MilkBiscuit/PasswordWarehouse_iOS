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
    @State private var websiteExists = false
    @State private var storeButtonDisabled = true
    @State private var confirmingToDelete = false
    @State private var navPath = NavigationPath()
    @Environment(\.kumaToastText) var toastText: Binding<String?>
    
    @Inject
    private var removeCredentialUC: RemoveCredentialUC
    @Inject
    private var searchCredentialUC: SearchCredentialUC
    @Inject
    private var storeCredentialUC: StoreCredentialUC

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
                )
                .textInputAutocapitalization(TextInputAutocapitalization.never)
                KumaPasswordField(
                    text: $password
                )
                .textInputAutocapitalization(TextInputAutocapitalization.never)
                
                Spacer().frame(height: 20)
                Button(action: {generatingPassword.toggle()}) {
                    Text("Generate Password")
                        .frame(maxWidth: .infinity)
                }
                Spacer().frame(height: 20)
                Button(action: storeCredentials) {
                    Label(
                        websiteExists ? "Update": "Store",
                        systemImage: "square.and.arrow.down"
                    )
                    .frame(maxWidth: .infinity)
                }
                .disabled(storeButtonDisabled)
                .buttonStyle(.borderedProminent)
                if websiteExists {
                    Spacer().frame(height: 20)
                    Button(role: .destructive, action: { confirmingToDelete = true }) {
                        Image(systemName: "trash")
                    }
                    .confirmationDialog("Are you sure?", isPresented: $confirmingToDelete) {
                        Button("Delete this password", role: .destructive) {
                            removeCredential()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
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
            .onChange(of: website, onWebsiteChange)
            .onChange(of: username, updateStoreButtonState)
            .onChange(of: password, updateStoreButtonState)
            .navigationDestination(for: CredentialList.self) { list in
                SearchResultListView(
                    credentialList: list,
                    copy: copyToClipboard
                )
            }
            .sheet(isPresented: $generatingPassword) {
                GeneratePasswordView(useAction: {tempPassword in self.password = tempPassword})
            }
        }
    }
    
    private func clearForm() {
        self.website = ""
        self.username = ""
        self.password = ""
    }

    private func copyToClipboard(_ content: String) {
        UIPasteboard.general.string = content
        toastText.wrappedValue = "Copied to clipboard"
    }
    
    private func onWebsiteChange() {
        websiteExists = false
        updateStoreButtonState()
    }
    
    private func removeCredential() {
        Task {
            let removeSuccess = await removeCredentialUC.invoke(website: self.website)
            if removeSuccess { clearForm() }
        }
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
            Task {
                try await Task.sleep(for: .milliseconds(50))
                websiteExists = true
            }
        } else {
            navPath.append(results)
        }
    }

    private func storeCredentials() {
        storeCredentialUC.invoke(
            credential: CredentialItem(id: website, username: username, passwordClearText: password)
        )
        clearForm()
    }
    
    private func updateStoreButtonState() {
        if website.isEmpty {
            storeButtonDisabled = true
            return
        }
        if username.isEmpty && password.isEmpty {
            storeButtonDisabled = true
            return
        }
        storeButtonDisabled = false
    }
}


#Preview {
    HomeView()
}
