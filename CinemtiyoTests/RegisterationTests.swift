//
//  CinemtiyoTests.swift
//  CinemtiyoTests
//
//  Created by Vinayak Sareen on 04/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import XCTest


@testable import Cinemtiyo

class CinemtiyoTests: XCTestCase {
    
    var signup: SliderSignupCellCollectionViewCell!
    
    override func setUp() {
        signup = SliderSignupCellCollectionViewCell()
    }
    
    override func tearDown() {
        signup = nil
    }
    
    func testregisterationMissingUsername() {
        let result = signup.missingChecks(username: "", email: "sareenv@uni.coventry.ac.uk", password: "BXWT3-fgd")
        XCTAssertEqual(result, true)
    }
    
    
    func testregisterationMissingEmail() {
       let result = signup.missingChecks(username: "sareenv", email: "", password: "BXWT3-fgd")
       XCTAssertEqual(result, true)
    }
    
    func testShortPassword() {
        let result = signup.checkShortPassword(password: "124")
        XCTAssertEqual(result, true)
    }
    
    func testValidLengthPassword() {
        let result = signup.checkShortPassword(password: "BXWT3-db")
        XCTAssertEqual(result, false)
    }
    
    func testregisterationInvalidEmail() {
        let result = signup.isValidEmail(email: "1234")
        XCTAssertEqual(result, false)
    }
    
    func testregisterationVaildEmail() {
        let result = signup.isValidEmail(email: "vsareen2@gmail.com")
        XCTAssertEqual(result, true)
    }
    
    func testregisterationMissingPassword() {
        let result = signup.missingChecks(username: "sareenv", email: "sareenv@uni.coventry.ac.uk", password: "")
        XCTAssertEqual(result, true)
    }

}
