//
//  ContentView.swift
//  PasswordWarehouse_iOS
//
//  Created by ChandlerC on 17/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        TabView {
            HomeView().tabItem() {
                Image(systemName: "house")
                Text("Home")
            }
            GeneratePasswordView().tabItem() {
                Image(systemName: "arrow.clockwise")
                Text("Generate")
            }
            ImportExportView().tabItem() {
                Image(systemName: "arrow.up.arrow.down")
                Text("Import & Export")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
