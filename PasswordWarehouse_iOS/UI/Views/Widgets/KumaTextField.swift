//
//  KumaTextField.swift
//  PasswordWarehouse_iOS
//
//  Created by ChandlerC on 19/11/23.
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

struct KumaTextField: View {
    
    @Binding private var text: String
    private let labelImage: String
    private let title: String
    
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
        .background(Color.kumaTealLight)
        .labeledContentStyle(.vertical)
    }
}

#Preview {
    KumaTextField("Website", labelImage: "doc.on.doc", text: .constant("Facebook"))
}
