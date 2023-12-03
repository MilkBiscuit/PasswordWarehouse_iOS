//
//  KumaToastView.swift
//  PasswordWarehouse_iOS
//
//  Copyright © 2023 Chandler Cheng. All rights reserved.
//

import SwiftUI


struct Toast: Equatable {
    var message: String
    var duration: Double = 3
}

struct KumaToastView: View {
    @Environment(\.colorScheme) var colorScheme
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        let isDarkBg: Bool = colorScheme == .light
        let textColor = isDarkBg ? Color.white : Color.black

        HStack(alignment: .top) {
            Text(self.text).foregroundColor(textColor)
            Spacer(minLength: 2) // Required for BG round corner
        }
        .padding()
        .background(Color.systemBackground.colorInvert())
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    KumaToastView(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tincidunt eleifend facilisis. Curabitur interdum pharetra porta. Curabitur vel mi eu velit mattis fermentum id vel dolor. Integer facilisis consectetur ex quis sollicitudin.")
}

struct ToastModifier: ViewModifier {
    @State var toastText: String? = nil
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                }
                    .animation(.spring(), value: toastText)
            )
            .environment(\.kumaToastText, $toastText)
            .onChange(of: toastText, { showToast() })
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toastMessage = toastText {
            VStack {
                Spacer()
                KumaToastView(
                    text: toastMessage
                )
                Spacer().frame(height: 60)
            }
        }
    }
    
    private func showToast() {
        if (toastText == nil) { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let toastDuration: Double = 3
        workItem?.cancel()
        
        let task = DispatchWorkItem {
            dismissToast()
        }
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + toastDuration, execute: task)
    }
    
    private func dismissToast() {
        withAnimation {
            toastText = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
