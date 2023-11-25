//
//
// PersistentFileHelper.swift
//
// Created on 25/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation


struct PersistentFileHelper {
    
    static func fileURL(fileName: String) -> URL {
        try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent(fileName)
    }
    
    static func readFromFile<T>(_ type: T.Type, from fileUrl: URL) async -> T? where T: Decodable {
        guard let data = await readFromFile(fileUrl: fileUrl) else {
            return nil
        }
        
        return try? JSONDecoder().decode(type, from: data)
    }
    
    static func readFromFile(fileUrl: URL) async -> Data? {
        let task = Task<Data?, Error> {
            return try? Data(contentsOf: fileUrl)
        }

        return try? await task.value
    }
    
    static func writeToFile<T>(fileUrl: URL, value: T) async -> Bool where T: Encodable {
        do {
            let data = try JSONEncoder().encode(value)

            return await writeToFile(fileUrl: fileUrl, data: data)
        } catch {
            print("writeToFile encode value failed! \(fileUrl)")
            print(error.localizedDescription)
            
            return false
        }
    }

    static func writeToFile(fileUrl: URL, data: Data) async -> Bool {
        let task = Task {
            try data.write(to: fileUrl)
        }
        do {
            try await task.value
            
            return true
        } catch {
            print("writeToFile failed! \(fileUrl)")
            print(error.localizedDescription)
            
            return false
        }
    }
}
