//
//  SearchResult.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/3/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import Foundation

struct SearchResult {
    
    var name: String
    var diningHall: String?
    var date: Date?
    var meal: String?
    
    // helper properties
    var dayIndex: Int
    var diningHallIndex: Int
    var mealIndex: Int
    
    var subtitle: String? {
        guard let date = date, let diningHall = diningHall, let meal = meal else { return nil }
        return "\(date.description) -> \(diningHall) -> \(meal)"
    }
}
