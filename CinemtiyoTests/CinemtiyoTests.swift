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

    func registerationMissingUsername() {
        let result = signup.missingChecks(username: "", email: "sareenv@uni.coventry.ac.uk", password: "BXWT3-fgd")
        XCTAssertEqual(result, false)
    }
    
    func registerationMissingEmail() {
        let result = signup.missingChecks(username: "sareenv", email: "", password: "BXWT3-fgd")
        XCTAssertEqual(result, false)
    }
    
    func registerationMissingPassword() {
        let result = signup.missingChecks(username: "sareenv", email: "sareenv@uni.coventry.ac.uk", password: "")
        XCTAssertEqual(result, false)
    }

}
