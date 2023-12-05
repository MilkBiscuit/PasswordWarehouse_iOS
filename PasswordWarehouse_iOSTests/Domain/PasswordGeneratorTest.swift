//
//
// EncryptTest.swift
//
// Created on 19/11/23
// Copyright © 2023 Chandler Cheng. All rights reserved.
//

import XCTest
import PasswordWarehouse_iOS

final class PasswordGeneratorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleCategoryPassword() {
        // Given the rule is password only contains lowercase
        var rule = PasswordRule(hasLowerCase: true, hasUpperCase: false, hasNumber: false, hasSymbol: false, length: 4)
        var password = PasswordGenerator.invoke(rule: rule)
        let allLowercase = password.allSatisfy() { $0.isLowercase }
        print("all lowercase password: \(password)")
        XCTAssertTrue(allLowercase)
        XCTAssertEqual(rule.length, password.count)

        // Given the rule is password only contains uppercase
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: true, hasNumber: false, hasSymbol: false, length: 6)
        password = PasswordGenerator.invoke(rule: rule)
        let allUppercase = password.allSatisfy() { $0.isUppercase }
        print("all uppercase password: \(password)")
        XCTAssertTrue(allUppercase)
        XCTAssertEqual(rule.length, password.count)

        // Given the rule is password only contains number
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: false, hasNumber: true, hasSymbol: false, length: 12)
        password = PasswordGenerator.invoke(rule: rule)
        let allNumber = password.allSatisfy() { $0.isNumber }
        print("all number password: \(password)")
        XCTAssertTrue(allNumber)
        XCTAssertEqual(rule.length, password.count)

        // Given the rule is password only contains symbol
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: false, hasNumber: false, hasSymbol: true, length: 20)
        password = PasswordGenerator.invoke(rule: rule)
        let allSymbol = password.allSatisfy() { $0.isPunctuation || $0.isMathSymbol }
        print("all symbol password: \(password)")
        XCTAssertTrue(allSymbol)
        XCTAssertEqual(rule.length, password.count)
    }

    func testMultipleCategoryPassword() {
        // Given the rule is password contains characters from 2 categories
        var rule = PasswordRule(hasLowerCase: true, hasUpperCase: true, hasNumber: false, hasSymbol: false, length: 6)
        var password = PasswordGenerator.invoke(rule: rule)
        let allLetters = password.allSatisfy() { $0.isLetter }
        print("all letter password: \(password)")
        XCTAssertTrue(allLetters)
        XCTAssertEqual(rule.length, password.count)
        
        // Given the rule is password contains characters from 3 categories
        rule = PasswordRule(hasLowerCase: true, hasUpperCase: true, hasNumber: true, hasSymbol: false, length: 8)
        password = PasswordGenerator.invoke(rule: rule)
        let alphaNumeric = password.allSatisfy() { $0.isLetter || $0.isNumber }
        print("alphaNumeric password: \(password)")
        XCTAssertTrue(alphaNumeric)
        XCTAssertEqual(rule.length, password.count)
        
        // Given the rule is password contains characters from 4 categories
        rule = PasswordRule(hasLowerCase: true, hasUpperCase: true, hasNumber: true, hasSymbol: true, length: 4)
        password = PasswordGenerator.invoke(rule: rule)
        print("all-4-category password: \(password)")
        XCTAssertTrue(password.contains { $0.isUppercase })
        XCTAssertTrue(password.contains { $0.isLowercase })
        XCTAssertTrue(password.contains { $0.isNumber })
        XCTAssertTrue(password.contains { $0.isPunctuation || $0.isMathSymbol })
        XCTAssertEqual(rule.length, password.count)

        rule = PasswordRule(hasLowerCase: true, hasUpperCase: true, hasNumber: true, hasSymbol: true, length: 20)
        password = PasswordGenerator.invoke(rule: rule)
        print("all-4-category password, size 20: \(password)")
        XCTAssertTrue(password.contains { $0.isUppercase })
        XCTAssertTrue(password.contains { $0.isLowercase })
        XCTAssertTrue(password.contains { $0.isNumber })
        XCTAssertTrue(password.contains { $0.isPunctuation || $0.isMathSymbol })
        XCTAssertEqual(rule.length, password.count)
    }

}
