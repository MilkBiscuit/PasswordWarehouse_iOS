//
//  GeneratePasswordView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct GeneratePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        ZStack {
            Color.green
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 100.0))
                Button("Press to dismiss") {
                    dismiss()
                }
                .font(.title)
            }
        }
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
    }
}

#Preview {
    GeneratePasswordView()
}
