//
//  GeneratePasswordView.swift
//  PasswordWarehouse_iOS
//
//  Created by Chandler Cheng on 19/11/23.
//

import SwiftUI

struct GeneratePasswordView: View {
    var body: some View {
        ZStack {
            Color.green
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    GeneratePasswordView()
}
