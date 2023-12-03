//
//
// TextDocument.swift
//
// Created on 1/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct TextDocument: FileDocument {
    static var readableContentTypes: [UTType] {
        [.json, .plainText]
    }
    
    var text = ""
    
    init(text: String) {
        self.text = text
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            text = ""
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: Data(text.utf8))
    }
}
