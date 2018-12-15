//
//  DiningPaws+DateTests.swift
//  DiningPawsTests
//
//  Created by Alexander Kerendian on 12/14/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import XCTest
@testable import DiningPaws

class DateTests: XCTestCase {
    
    func testDateComparison() {
        let date1 = Date()
        sleep(2)
        let date2 = Date()
        let comparison = date1.isEqual(to: date2)
        XCTAssertEqual(comparison, true)
    }
}
