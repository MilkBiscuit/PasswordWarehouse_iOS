//
//
// KumaTextFieldAlert.swift
//
// Created on 2/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct KumaTextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    let presenting: Presenting
    let description: String
    var onPositive: (String) -> Void
    @Environment(\.colorScheme) var colorScheme
    @State private var text: String = "Some default input"

    var body: some View {
        // TODO: The UI effect under dark mode
//        let isDarkBg: Bool = colorScheme == .light
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting.disabled(isShowing)
                VStack {
                    Text(self.description).font(.headline)
                    Spacer().frame(height: 30)
                    
                    // TODO: Use secure text field
                    TextField(self.description, text: self.$text)
                        .textFieldStyle(.roundedBorder)

                    Spacer().frame(height: 30)

                    HStack {
                        Button(action: {
                            onPositive(self.text)
                            withAnimation { self.isShowing = false }
                        }) {
                            Text("OK")
                        }
                    }
                }
                .padding([.horizontal], 24)
                .padding([.vertical], 16)
                .background(.background)
                .frame(
                    width: deviceSize.size.width * 0.9,
                    height: deviceSize.size.height * 0.9
                )
                .shadow(radius: 100)
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
                 .frame(width: 100, height: 100)
                 .foregroundColor(.blue)
                 .navigationBarTitle(Text("Any random view"), displayMode: .automatic)
         }
         .textFieldAlert(
             isShowing: $isShowing,
             description: "Please input master password\n(Note: this will be asked for import).",
             onPositive: {_ in }
         )
     }
}

#Preview {
    KumaTextFieldAlertPreview()
}
#endif
