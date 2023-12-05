//
//  GeneratePasswordView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct GeneratePasswordView: View {
    let defaultRule = PasswordRule(
        hasLowerCase: true, hasUpperCase: true, hasNumber: true, hasSymbol: false, length: 8
    )
    @Environment(\.dismiss) var dismiss
    @State private var sheetHeight: CGFloat = .zero
    @State private var passwordRule: PasswordRule
    @State private var password: String
    var useAction: TextCallback

    init(useAction: @escaping TextCallback) {
        let initialPassword = PasswordGenerator.invoke(rule: defaultRule)
        _password = State(initialValue: initialPassword)
        _passwordRule = State(initialValue: defaultRule)
        self.useAction = useAction
    }

    var body: some View {
        VStack {
            Toggle("Uppercase", isOn: $passwordRule.hasUpperCase)
            Toggle("Lowercase", isOn: $passwordRule.hasLowerCase)
            Toggle("Number", isOn: $passwordRule.hasNumber)
            Toggle("Symbol", isOn: $passwordRule.hasSymbol)
            Stepper("Length:  \(passwordRule.length)", value: $passwordRule.length, in: PasswordGenerator.passwordLenRange)
            Spacer().frame(height: 20)
            KumaTextField(
                "Password", labelImage: KumaPasswordField.passwordLabelImage, text: $password
            )
            .disabled(true)

            Spacer().frame(height: 20)
            Button(action: regenerate) {
                Label("Generate", systemImage: "arrow.clockwise")
                    .frame(maxWidth: .infinity)
            }
            Spacer().frame(height: 20)
            Button(action: usePassword) {
                Text("Use this password")
                    .frame(maxWidth: .infinity)
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
    
    private func regenerate() {
        let newPassword = PasswordGenerator.invoke(rule: passwordRule)
        password = newPassword
    }
    
    private func usePassword() {
        useAction(password)
        dismiss()
    }
}

#Preview {
    GeneratePasswordView(useAction: {_ in})
}
