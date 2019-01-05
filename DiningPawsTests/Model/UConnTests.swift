//
//  UConnTests.swift
//  DiningPawsTests
//
//  Created by Alexander Kerendian on 12/14/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import XCTest
@testable import DiningPaws

class UConnTests: XCTestCase {
    
    func testStatusForDiningHallAndDate() {
        guard let diningHall = UConn.initializeNewDiningHalls().first else { return }
        let today = Date()
        var date: Date? = today
        while date?.hour ?? 0 < 22 {
            date = Calendar.current.date(byAdding: .hour, value: 1, to: date!)
        }
        let status = UConn.status(for: diningHall, on: today)
        XCTAssertEqual(status, "CLOSED")
    }
}
