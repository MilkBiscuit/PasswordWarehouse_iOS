//
//  ColorExtension.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI

extension Color {
    static var systemBackground: Color {
        Color(UIColor.systemBackground)
    }
    static var lightGray: Color {
        Color(UIColor.lightGray)
    }
    static var kumaTeal: Color {
        Color(red: 0, green: 0.592, blue: 0.655)
    }
    static var kumaYellow: Color {
        Color(red: 1, green: 1, blue: 0.298)
    }
    static var kumaDark: Color {
        Color(red: 0.2, green: 0.2, blue: 0.2)
    }
    static var kumaTealLight: Color {
        Color(red: 0, green: 0.592, blue: 0.655, opacity: 0.2)
    }
}
