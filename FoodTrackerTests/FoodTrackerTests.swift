//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Hanlin Chen on 5/26/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import XCTest
@testable import FoodTracker
class FoodTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Meal Class Tests
    // Comfirm that Meal initializer  return a meal object when pass valid parameters
    func testMealInitializationSucceeds(){
        // zero rating
        let zeroRatingMeal = Meal(name: "Zero", photo: nil, rating: 5)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal(name :"Positive", photo:nil, rating:5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    // Comfirm that the Meal initializer retuns nil when pass a negative  rating or an empty bame
    func testMealInitilizationFails(){
        let negativeRatingMeal = Meal(name:"Negative", photo:nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        let largeRatingMeal = Meal(name:"large", photo:nil, rating:6)
        XCTAssertNil(largeRatingMeal)
        
        let emptyStringMeal = Meal(name:"", photo: nil, rating:0)
        XCTAssertNil(emptyStringMeal)
    }
}
