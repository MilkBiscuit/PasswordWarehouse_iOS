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
    @State private var askingPasswordForImport = false
    @State private var document = TextDocument(text: "")
    
    @Inject
    private var exportCredentialsUC: ExportCredentialsUC
    @Inject
    private var importCrendentialsUC: ImportCredentialsUC

    var body: some View {
        let askingPasswordBind = Binding<Bool>(
            get: { self.askingPasswordForExport || self.askingPasswordForImport },
            set: { _ in self.askingPasswordForExport = false; self.askingPasswordForImport = false }
        )

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
                    clickAction: { askingPasswordForImport = true }
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
            contentType: .plainText,
            defaultFilename: "Passwords.json"
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
            allowedContentTypes: [.plainText]
        ) { result in
            switch result {
            case .success(let file):
                Task {
                    let importCount = await importCrendentialsUC.invoke(fileUrl: file, masterPassword: "2hFg8-T-jCFh")
                    print("Imported \(importCount) passwords.")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .textFieldAlert(
            isShowing: askingPasswordBind,
            description: "Please input master password\n(Note: this will be asked for import).",
            onPositive: onPasswordEntered
        )
    }
    
    private func onPasswordEntered(userInput: String) {
        if (userInput.isEmpty) {
            // TODO: Show a toast in parent
            print("userInput empty!")
            
            return
        }
        
        if (askingPasswordForExport) {
            onPasswordEnteredForExport(userInput)
        } else if (askingPasswordForImport) {
            // TODO: import
        }
    }
    
    private func onPasswordEnteredForExport(_ userInput: String) {
        Task {
            guard let fileContent = await exportCredentialsUC.invoke(
                masterPassword: userInput
            ) else {
                print("Nothing to export!")
                return
            }
            document = TextDocument(text: fileContent)
            exporting = true
        }
    }
}

#Preview {
    SettingsView()
}
