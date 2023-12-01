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
        onPositive: @escaping (String) -> Void
    ) -> some View {
        KumaTextFieldAlert(
            isShowing: isShowing,
            presenting: self,
            description: description,
            onPositive: onPositive
        )
    }
}
