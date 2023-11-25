//
//  VisiblePasswordField.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

struct KumaPasswordField: View {
    private let iconWidth: CGFloat = 44
    private let iconPanelWidth: CGFloat
    private let labelText: String = "Password"
    private let labelImage: String = "rectangle.and.pencil.and.ellipsis"

    private var copyToClipboard: () -> Void
    @Binding private var password: String
    @State private var isSecured: Bool = false
    
    init(text: Binding<String>, copy callback: @escaping () -> Void) {
        self._password = text
        self.copyToClipboard = callback
        self.iconPanelWidth = iconWidth * 2
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    LabeledContent {
                        SecureField(labelText, text: $password)
                            .padding([.leading, .bottom], 8)
                    } label: {
                        Label(labelText, systemImage: labelImage)
                            .font(.caption)
                            .padding([.top, .leading], 8)
                    }
                    .background(Color.kumaTealLight)
                    .labeledContentStyle(.vertical)
                } else {
                    KumaTextField(
                        "Password", labelImage: labelImage, text: $password
                    )
                }
            }.padding(.trailing, iconPanelWidth)
            
            HStack(spacing: 0) {
                Button(action: {isSecured.toggle()}) {
                    Image(systemName: self.isSecured ? "eye" : "eye.slash")
                        .accentColor(.gray)
                }
                .frame(minWidth: iconWidth, maxHeight: .infinity)
                Button(action: copyToClipboard) {
                    Image(systemName: "doc.on.doc")
                        .accentColor(.gray)
                }
                .frame(minWidth: iconWidth, maxHeight: .infinity)
            }
            .frame(minWidth: iconPanelWidth, maxHeight: .infinity)
            .background(Color.kumaTealLight)
        }
        // true means child views should only take the space they need
        .fixedSize(horizontal: false, vertical: true)
    }

}

#Preview {
    KumaPasswordField(text: .constant("AAA"), copy: {})
}
