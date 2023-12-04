//
//
// GeneratePassword.swift
//
// Created on 4/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

class PasswordGenerator {
    static let lowercaseLetters: String = "abcdefghijkmnpqrstuvwxyz" // Remove l and o
    static let uppercaseLetters: String = "ABCDEFGHJKLMNPQRSTUVWXYZ" // Remove I and O
    static let numbers: String = "1234567890"
    static let symbols: String = "@#_-=>|+*[:"
    
    static func invoke(rule: PasswordRule) -> String {
        var passwordBuilder = ""
        var allPossibleChars = ""
        if (rule.hasLowerCase) {
            passwordBuilder += String(lowercaseLetters.randomElement()!)
            allPossibleChars += lowercaseLetters
        }
        if (rule.hasUpperCase) {
            passwordBuilder += String(uppercaseLetters.randomElement()!)
            allPossibleChars += uppercaseLetters
        }
        if (rule.hasNumber) {
            passwordBuilder += String(numbers.randomElement()!)
            allPossibleChars += numbers
        }
        if (rule.hasSymbol) {
            passwordBuilder += String(symbols.randomElement()!)
            allPossibleChars += symbols
        }
        let numOfRemainingCharacters = rule.length - passwordBuilder.count
        (0...numOfRemainingCharacters).forEach { _ in
            passwordBuilder += String(allPossibleChars.randomElement()!)
        }
        
        return passwordBuilder
    }
}
