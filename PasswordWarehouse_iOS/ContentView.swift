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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
