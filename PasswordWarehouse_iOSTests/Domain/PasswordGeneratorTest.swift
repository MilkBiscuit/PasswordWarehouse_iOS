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

        // Given the rule is password only contains uppercase
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: true, hasNumber: false, hasSymbol: false, length: 4)
        password = PasswordGenerator.invoke(rule: rule)
        let allUppercase = password.allSatisfy() { $0.isUppercase }
        print("all uppercase password: \(password)")
        XCTAssertTrue(allUppercase)

        // Given the rule is password only contains number
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: false, hasNumber: true, hasSymbol: false, length: 4)
        password = PasswordGenerator.invoke(rule: rule)
        let allNumber = password.allSatisfy() { $0.isNumber }
        print("all number password: \(password)")
        XCTAssertTrue(allNumber)

        // Given the rule is password only contains symbol
        rule = PasswordRule(hasLowerCase: false, hasUpperCase: false, hasNumber: false, hasSymbol: true, length: 4)
        password = PasswordGenerator.invoke(rule: rule)
        let allSymbol = password.allSatisfy() { $0.isPunctuation || $0.isMathSymbol }
        print("all symbol password: \(password)")
        XCTAssertTrue(allSymbol)
    }

    func testMultipleCategoryPassword() {
        // Given the rule is password contains characters from 2 categorie
        var rule = PasswordRule(hasLowerCase: true, hasUpperCase: true, hasNumber: false, hasSymbol: false, length: 4)
        var password = PasswordGenerator.invoke(rule: rule)
        // TODO: continue
    }

}
