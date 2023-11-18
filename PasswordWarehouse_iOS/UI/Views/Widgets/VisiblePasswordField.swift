//
//  VisiblePasswordField.swift
//  PasswordWarehouse_iOS
//
//  Created by ChandlerC on 19/11/23.
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

struct VisiblePasswordField: View {
    @Binding private var text: String
    @State private var isSecured: Bool = false
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
            }.padding(.trailing, 32)

            Button(action: {isSecured.toggle()}) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}

#Preview {
    VisiblePasswordField("Password", text: .constant("AAA"))
}
