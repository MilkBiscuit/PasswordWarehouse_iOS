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
}
