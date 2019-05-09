//
//  FinalProjectTests.swift
//  FinalProjectTests
//
//  Created by Kenny Casey on 5/2/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import XCTest
@testable import FinalProject

class FinalProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        var test = Stock(symbol: "X")
            
            self.measure(test.generateStockHistory(forInterval: .day))
            self.measure(test.generateStockHistory(forInterval: .week))
            
        }
    }

}
