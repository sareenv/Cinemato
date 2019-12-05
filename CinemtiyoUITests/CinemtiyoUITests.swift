//
//  CinemtiyoUITests.swift
//  CinemtiyoUITests
//
//  Created by Vinayak Sareen on 05/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import XCTest

class CinemtiyoUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    func testSliderRegisteration() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Digital Charity Application").element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Connect with community").element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Awesome Feeling").element.swipeLeft()
        let usernameTextField = collectionViewsQuery.textFields["Enter Username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("sareenv")
        let emailTextField = collectionViewsQuery.textFields["Enter email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("vsareen2@gmail.com")
        let passwordTextField = collectionViewsQuery.secureTextFields["Enter password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("BXWT3-db")
        let createAccountbutton = collectionViewsQuery.buttons["Select Profile Image"]
        XCTAssertTrue(createAccountbutton.exists)
        createAccountbutton.tap()
        expectation(for: NSPredicate(format: "exists == 1", argumentArray: nil), evaluatedWith: createAccountbutton, handler: nil)
        waitForExpectations(timeout: 6, handler: nil)
        
    }
}
