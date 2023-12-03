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
    @State private var hasUppercase: Bool = true
    @State private var hasLowercase: Bool = true
    @State private var hasNumber: Bool = true
    @State private var hasSymbol: Bool = false
    @State private var length = 10
    
    var body: some View {
        VStack {
            Toggle("Uppercase", isOn: $hasUppercase)
            Toggle("Lowercase", isOn: $hasLowercase)
            Toggle("Number", isOn: $hasNumber)
            Toggle("Symbol", isOn: $hasSymbol)
            Stepper("Length:  \(length)", value: $length, in: 4...20)
            Spacer().frame(height: 20)
            KumaPasswordField(text: .constant("AABBCC"))

            Spacer().frame(height: 20)
            Button(action: {}) {
                Label("Generate", systemImage: "arrow.clockwise")
            }
            Spacer().frame(height: 20)
            Button(action: { dismiss() }) {
                Text("Use this password")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
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
