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
    @State private var document = TextDocument(text: "Hello World!")

    var body: some View {
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
                    clickAction: {importing = true}
                )
                KumaPreferenceItem(
                    text: "Export",
                    clickAction: {exporting = true}
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
                print("Import \(file) success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    SettingsView()
}
