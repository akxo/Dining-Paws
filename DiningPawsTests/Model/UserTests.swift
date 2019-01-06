//
//  UserTests.swift
//  DiningPawsTests
//
//  Created by Alexander Kerendian on 12/14/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import XCTest
@testable import DiningPaws

class UserTests: XCTestCase {
    
    func testAddFavorites() {
        let user = User(favorites: [], enabledFavorites: [], homeDiningHall: nil, locationBasedLoadIsEnabled: false)
        user.add("Sundae Bar")
        user.add("Chicken Tenders")
        user.add("Quesadilla Bar")
        
        XCTAssertEqual(user.favorites, ["Chicken Tenders", "Quesadilla Bar", "Sundae Bar"])
        XCTAssertEqual(user.enabledFavorites, ["Chicken Tenders", "Quesadilla Bar", "Sundae Bar"])
    }
    
    func testRemoveFavorites() {
        let user = User(favorites: [], enabledFavorites: [], homeDiningHall: nil, locationBasedLoadIsEnabled: false)
        user.add("Sundae Bar")
        user.add("Chicken Tenders")
        user.add("Quesadilla Bar")
        
        user.remove("Quesadilla Bar")
        user.remove("Chicken Tenders")
        
        XCTAssertEqual(user.favorites, ["Sundae Bar"])
        XCTAssertEqual(user.enabledFavorites, ["Sundae Bar"])
    }
    
    func testChangeEnabledSatus() {
        let user = User(favorites: [], enabledFavorites: [], homeDiningHall: nil, locationBasedLoadIsEnabled: false)
        user.add("Sundae Bar")
        user.add("Quesadilla Bar")
        user.add("Chicken Tenders")
        
        user.changeStatus(for: "Sundae Bar")
        user.changeStatus(for: "Chicken Tenders")
        user.changeStatus(for: "Quesadilla Bar")
        user.changeStatus(for: "Quesadilla Bar")
        
        XCTAssertEqual(user.favorites, ["Chicken Tenders", "Quesadilla Bar", "Sundae Bar"])
        XCTAssertEqual(user.enabledFavorites, ["Quesadilla Bar"])
    }
}
