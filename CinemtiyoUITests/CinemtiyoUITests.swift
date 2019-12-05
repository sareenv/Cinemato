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
        app.launchArguments.append("--sliderTesting")
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }
    
    func testSlidersInvalidRegisterationDetails() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Trending Movies").element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Connect with Entertainment").element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Awesome Feeling").element.swipeLeft()
        let usernameTextField = collectionViewsQuery.textFields["Enter Username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("")
        let emailTextField = collectionViewsQuery.textFields["Enter email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("vsareen2@gmail.com")
        let passwordTextField = collectionViewsQuery.secureTextFields["Enter password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("")
        collectionViewsQuery.buttons["Create an Account"].tap()
        let alert = app.alerts["Missing Details Error"].scrollViews.otherElements
        let alertActionButton = alert.buttons["OK"]
         XCTAssertTrue(alertActionButton.exists)
        alertActionButton.tap()
        
    }
}
