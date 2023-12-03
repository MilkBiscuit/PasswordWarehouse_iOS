//
//  ImportExportView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct SettingsView: View {

    @State private var importing = false
    @State private var exporting = false
    @State private var askingPasswordForExport = false
    @State private var fileForImport: URL? = nil
    @State private var document = TextDocument(text: "")
    @Environment(\.kumaToastText) var toastText: Binding<String?>
    
    @Inject
    private var exportCredentialsUC: ExportCredentialsUC
    @Inject
    private var importCrendentialsUC: ImportCredentialsUC

    var body: some View {
        let askingPasswordBind = Binding<Bool>(
            get: { self.askingPasswordForExport || self.fileForImport != nil},
            set: { _ in self.askingPasswordForExport = false; self.fileForImport = nil }
        )
        let passwordPopupEntryText = if (askingPasswordForExport) {
            "Import requires this password, so don't forget it."
        } else if (fileForImport != nil) {
            "What password did you use during export?"
        } else { "" }

        List {
            Spacer(minLength: 50)
                .listRowSeparator(.hidden)

            Section(header: Text("Settings").font(.headline)) {
                KumaTogglePreference(
                    isToggleOn: .constant(false),
                    text: "Face ID",
                    description: "Use Face ID when launching Password Bin"
                )
            }

            Section(header: Text("Import & Export").font(.headline)) {
                KumaPreferenceItem(
                    text: "Import",
                    clickAction: { importing = true }
                )
                KumaPreferenceItem(
                    text: "Export",
                    clickAction: { askingPasswordForExport = true }
                )
            }
            
            Spacer(minLength: 50)
            
            Button(action: {}) {
                Label(
                    title: { Text("About Password Bin") },
                    icon: { Image(uiImage: UIImage(named: "AppIcon") ?? UIImage()) }
                )
            }
            .modifier(CenterModifier())
            .buttonStyle(.bordered)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .fileExporter(
            isPresented: $exporting,
            document: document,
            contentType: .json,
            defaultFilename: "Passwords"
        ) { result in
            switch result {
            case .success(let file):
                print("Export \(file) success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .fileImporter(
            isPresented: $importing,
            allowedContentTypes: [.json, .plainText]
        ) { result in
            switch result {
            case .success(let file):
                fileForImport = file
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .textFieldAlert(
            isShowing: askingPasswordBind,
            description: passwordPopupEntryText,
            onPositive: onPasswordEntered
        )
    }
    
    private func onPasswordEntered(userInput: String) {
        if (userInput.isEmpty) {
            toastText.wrappedValue = "Password can not be empty!"
            return
        }
        
        if (askingPasswordForExport) {
            onPasswordEnteredForExport(userInput)
        } else if (fileForImport != nil) {
            onPasswordEnteredForImport(userInput)
        }
    }
    
    private func onPasswordEnteredForExport(_ userInput: String) {
        Task {
            guard let fileContent = await exportCredentialsUC.invoke(
                masterPassword: userInput
            ) else {
                toastText.wrappedValue = "Nothing to export."
                return
            }
            document = TextDocument(text: fileContent)
            exporting = true
        }
    }
    
    private func onPasswordEnteredForImport(_ userInput: String) {
        guard let fileUrl = fileForImport else {
            return
        }
        Task {
            let importCount = await importCrendentialsUC.invoke(
                fileUrl: fileUrl, masterPassword: userInput)
            toastText.wrappedValue = "Imported \(importCount) password items."
        }
    }
}

#Preview {
    SettingsView()
}
