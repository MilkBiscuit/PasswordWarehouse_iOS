//
//
// KumaTextFieldAlert.swift
//
// Created on 2/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct KumaTextFieldAlert<Presenting>: View where Presenting: View {

    let presenting: Presenting
    @Binding var isShowing: Bool
    let description: String
    var onPositive: TextCallback
    @State private var text: String = ""

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting.disabled(isShowing)
                VStack (alignment: .leading) {
                    Text(self.description).font(.headline)
                    Spacer().frame(height: 30)
                    
                    // TODO: Use secure text field
                    TextField("Please input password.", text: self.$text)
                        .textFieldStyle(.roundedBorder)

                    Spacer().frame(height: 30)

                    HStack {
                        Button(action: {
                            onPositive(self.text)
                            withAnimation { self.isShowing = false }
                            self.text = ""
                        }) {
                            Text("OK")
                        }
                    }.frame(maxWidth: .infinity)
                }
                .padding([.horizontal], 24)
                .padding([.vertical], 16)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 25.0))
                .frame(
                    width: deviceSize.size.width * 0.9,
                    height: deviceSize.size.height * 0.9
                )
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

#if DEBUG
struct KumaTextFieldAlertPreview : View {
     @State
     private var isShowing = true

     var body: some View {
         NavigationView {
             Rectangle()
                 .frame(width: 150, height: 150)
                 .foregroundColor(.orange)
                 .navigationBarTitle(Text("An orange square"), displayMode: .automatic)
         }
         .textFieldAlert(
             isShowing: $isShowing,
             description: "Import requires this password, so don't forget!",
             onPositive: {_ in }
         )
     }
}

#Preview {
    KumaTextFieldAlertPreview()
}
#endif
