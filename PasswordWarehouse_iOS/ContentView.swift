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
            SettingsView().tabItem() {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
