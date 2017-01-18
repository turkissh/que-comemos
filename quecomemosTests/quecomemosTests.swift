//
//  quecomemosTests.swift
//  quecomemosTests
//
//  Created by Emiliano Di Pierro on 10/13/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import XCTest
@testable import quecomemos

class quecomemosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Meal tests
    func testCreateAMealWithNoNameShouldReturnNil(){
        let noName = Meal(name: "", rating: 3, image: nil)
        XCTAssertNil(noName,"Empty name is invalid")
    }
    
    func testCreateAMealWithInvalidRatingShouldReturnNil(){
        let noRating = Meal(name: "Comida", rating: -2, image: nil)
        XCTAssertNil(noRating,"Rating must be positive")
    }
    
    func testCreateAMealWithValidParametersShouldReturnTheMeal(){
        let aMeal = Meal(name: "Comida", rating: 3, image: nil)
        XCTAssertNotNil(aMeal)
        XCTAssert(aMeal?.name == "Comida", "Name must be Comida")
    }
}
