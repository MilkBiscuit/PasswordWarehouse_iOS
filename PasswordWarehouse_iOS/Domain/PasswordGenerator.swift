//
//
// GeneratePassword.swift
//
// Created on 4/12/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//
        

import Foundation

class PasswordGenerator {
    static let passwordLenRange = 4...20
    private static let lowercaseLetters: String = "abcdefghijkmnpqrstuvwxyz" // Remove l and o
    private static let uppercaseLetters: String = "ABCDEFGHJKLMNPQRSTUVWXYZ" // Remove I and O
    private static let numbers: String = "1234567890"
    private static let symbols: String = "@#_-=>|+*[:"

    static func invoke(rule: PasswordRule) -> String {
        precondition(passwordLenRange.contains(rule.length), "Password length has to be between 4 and 20.")
        
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
        (0..<numOfRemainingCharacters).forEach { _ in
            passwordBuilder += String(allPossibleChars.randomElement()!)
        }
        
        return shuffle(passwordBuilder)
    }
    
    private static func shuffle(_ string: String) -> String {
        let charArray: [Character] = Array(string)
        let shuffledArray: [Character] = charArray.shuffled()
        return String(shuffledArray)
    }
}
