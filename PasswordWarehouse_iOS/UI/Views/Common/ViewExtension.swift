//
//  ViewExtension.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

extension View {
    
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

    func toastView() -> some View {
        self.modifier(ToastModifier())
    }
}
