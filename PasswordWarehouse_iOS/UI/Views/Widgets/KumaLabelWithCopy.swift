//
//
// KumaLabelWithCopy.swift
//
// Created on 25/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct KumaLabelWithCopy: View {
    
    private var imageName: String
    private var text: String
    private var copyToClipboard: () -> Void
    
    init(labelImage: String, text: String, copy: @escaping () -> Void) {
        self.text = text
        self.imageName = labelImage
        self.copyToClipboard = copy
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Label {
                Text(text)
            } icon: {
                Image(systemName: imageName)
                    .font(Font.system(size: 12, design: .monospaced))
                    .frame(minWidth: 20)
            }
            Spacer()
            Button(action: copyToClipboard) {
                Image(systemName: "doc.on.doc")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        KumaLabelWithCopy(labelImage: "envelope", text: "dc9909@hotmail.com", copy: {})
        KumaLabelWithCopy(labelImage: "rectangle.and.pencil.and.ellipsis", text: "123456", copy: {})
    }
}
