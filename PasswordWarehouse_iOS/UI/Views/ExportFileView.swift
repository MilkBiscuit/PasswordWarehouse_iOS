//
//
// ExportFileView.swift
//
// Created on 1/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import SwiftUI

struct ExportFileView: View {
    @State private var exporting = false
    @State private var document = TextDocument(text: "abcd.json")
    
    var body: some View {
        NavigationView {
            Rectangle()
                .foregroundColor(Color.blue)
                .frame(width: 100, height: 100)
                .toolbar {
                    Button("Export") {
                        exporting = true
                    }
                    .fileExporter(
                        isPresented: $exporting,
                        document: document,
                        contentType: .plainText,
                        defaultFilename: "Passwords.json"
                    ) { result in
                        switch result {
                        case .success(let file):
                            print(file)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
    }
}


#Preview {
    ExportFileView()
}
