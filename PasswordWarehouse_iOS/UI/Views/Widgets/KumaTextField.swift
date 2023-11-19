//
//  KumaTextField.swift
//  PasswordWarehouse_iOS
//
//  Created by ChandlerC on 19/11/23.
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

struct KumaTextField: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding private var text: String
    private var labelImage: String
    private var title: String
    
    init(_ title: String, labelImage imageName: String = "", text: Binding<String>) {
        self.title = title
        self.labelImage = imageName
        self._text = text
    }

    var body: some View {
        LabeledContent {
            TextField("", text: $text)
                .disableAutocorrection(true)
                .padding([.leading, .bottom], 8)
        } label: {
            Label(title, systemImage: labelImage)
                .font(.caption)
                .padding([.top, .leading], 8)
        }
        .background(.regularMaterial)
        .labeledContentStyle(.vertical)
    }
}

#Preview {
    KumaTextField("Website", text: .constant("Facebook"))
}
