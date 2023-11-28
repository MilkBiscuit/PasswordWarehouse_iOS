//
//  ImportExportView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct SettingsView: View {
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
                    clickAction: {}
                )
                KumaPreferenceItem(
                    text: "Export",
                    clickAction: {}
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
    }
}

#Preview {
    SettingsView()
}
