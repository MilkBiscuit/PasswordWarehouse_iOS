//
//  ViewExtension.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
    
    func textFieldAlert(
        isShowing: Binding<Bool>,
        description: String,
        onPositive: @escaping TextCallback
    ) -> some View {
        KumaTextFieldAlert(
            presenting: self,
            isShowing: isShowing,
            description: description,
            onPositive: onPositive
        )
    }
}
