//
//  VisiblePasswordField.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

struct KumaPasswordField: View {
    static let passwordLabelImage: String = "rectangle.and.pencil.and.ellipsis"

    private let iconWidth: CGFloat = 44
    private let iconPanelWidth: CGFloat
    private let labelText: String = "Password"

    @Binding private var password: String
    @State private var isSecured: Bool = false
    private var showCopyIcon: Bool
    @Environment(\.kumaToastText) var toastText: Binding<String?>
    
    init(text: Binding<String>, showCopyIcon: Bool = true) {
        self._password = text
        self.showCopyIcon = showCopyIcon
        self.iconPanelWidth = showCopyIcon ? iconWidth * 2 : iconWidth
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    LabeledContent {
                        SecureField(labelText, text: $password)
                            .monospaced()
                            .padding([.leading, .bottom], 8)
                    } label: {
                        Label(labelText, systemImage: Self.passwordLabelImage)
                            .font(.caption)
                            .padding([.top, .leading], 8)
                    }
                    .background(Color.kumaTealLight)
                    .labeledContentStyle(.vertical)
                } else {
                    KumaTextField(
                        "Password", labelImage: Self.passwordLabelImage, text: $password
                    )
                }
            }.padding(.trailing, iconPanelWidth)
            
            HStack(spacing: 0) {
                Button(action: {isSecured.toggle()}) {
                    Image(systemName: self.isSecured ? "eye" : "eye.slash")
                        .accentColor(.gray)
                }
                .frame(minWidth: iconWidth, maxHeight: .infinity)
                if (showCopyIcon) {
                    Button(action: copyPasswordToClipboard) {
                        Image(systemName: "doc.on.doc")
                            .accentColor(.gray)
                    }
                    .frame(minWidth: iconWidth, maxHeight: .infinity)
                }
            }
            .frame(minWidth: iconPanelWidth, maxHeight: .infinity)
            .background(Color.kumaTealLight)
        }
        // true means child views should only take the space they need
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func copyPasswordToClipboard() {
        UIPasteboard.general.string = self.password
        let maskedPassword = String(repeating: "*", count: self.password.count)
        toastText.wrappedValue = "Copied \(maskedPassword) to clipboard"
    }

}

#Preview {
    KumaPasswordField(text: .constant("AAA"))
}
