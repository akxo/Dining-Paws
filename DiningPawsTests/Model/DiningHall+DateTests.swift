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
    
    func testDateEqualComparison() {
        let date1 = Date()
        sleep(2)
        let date2 = Date()
        let comparison = date1.isEqual(to: date2)
        XCTAssertEqual(comparison, true)
    }
    
    func testDateLessThanComparison() {
        let date1 = Date()
        sleep(2)
        let date2 = Date()
        let comparison1 = date1.isLess(than: date2)
        XCTAssertEqual(comparison1, false)
        
        guard let date3 = Calendar.current.date(byAdding: .day, value: 1, to: date1) else { return }
        let comparison2 = date1.isLess(than: date3)
        XCTAssertEqual(comparison2, true)
    }
}
