//
//  UConn.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/8/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation
import UIKit

struct UConn {
    
    static let lateNightDiningHalls = ["McMahon", "Northwest", "Whitney"]
    // sunday = 1, monday = 2, etc.
    static let lateNightWeekdays = ["1", "2", "3", "4", "5"]
    static let weekdays = ["2", "3", "4", "5", "6"]
    static let weeknds = ["7", "1"]
    
    static let primaryColor: UIColor = #colorLiteral(red: 0, green: 0.05490196078, blue: 0.1843137255, alpha: 0.800593964)
    static let secondaryColor: UIColor = #colorLiteral(red: 0.4862745098, green: 0.5294117647, blue: 0.5568627451, alpha: 0.7963934075)
    
    static func initializeNewDiningHalls() -> [DiningHall] {
        let buckley = DiningHall(name: "Buckley", locationNumber: "03", locationName: "Buckley+Dining+Hall", days: [])
        let mcmahon = DiningHall(name: "McMahon", locationNumber: "05", locationName: "McMahon+Dining+Hall", days: [])
        let north = DiningHall(name: "North", locationNumber: "07", locationName: "North+Campus+Dining+Hall", days: [])
        let northwest = DiningHall(name: "Northwest", locationNumber: "15", locationName: "Northwest+Marketplace", days: [])
        let putnam = DiningHall(name: "Putnam", locationNumber: "06", locationName: "Putnam+Dining+Hall", days: [])
        let south = DiningHall(name: "South", locationNumber: "16", locationName: "South+Campus+Marketplace", days: [])
        let towers = DiningHall(name: "Towers", locationNumber: "42", locationName: "Gelfenbien+Commons+%26+Halal", days: [])
        let whitney = DiningHall(name: "Whitney", locationNumber: "01", locationName: "Whitney+Dining+Hall", days: [])
        return [buckley, mcmahon, north, northwest, putnam, south, towers, whitney]
    }
    
    static func status(for diningHall: DiningHall) -> String {
        let date = Date()
        let weekday = date.weekday
        let hour = date.hour
        let minute = date.minute
        
        guard hour >= 7 else { return "CLOSED" }
        if hour < 8, weekday == "Sunday" { return "CLOSED" }
        if (hour < 9 || (hour == 9 && minute < 30)), weeknds.contains(weekday) {
            if diningHall.name != "South" {
                return "CLOSED"
            } else {
                return "Breakfast"
            }
        }
        if (hour < 10 || (hour == 10 && minute < 30)), weeknds.contains(weekday) {
            if diningHall.name == "South" || diningHall.name == "Towers" {
                return "Brunch"
            } else {
                return "CLOSED"
            }
        }
        if (hour < 10 || (hour == 10 && minute < 45)), weekdays.contains(weekday) { return "Breakfast" }
        if hour < 11, weekday.contains(weekday) { return "Between Meals" }
        if (hour < 14 || (hour == 14 && minute < 15)) {
            if weeknds.contains(weekday) {
                return "Brunch"
            } else {
                return "Lunch"
            }
        }
        if (hour < 15 || (hour == 15 && minute < 45)), diningHall.name == "McMahon" { return "CLOSED" }
        if (hour < 16 || (hour == 16 && minute < 15)) {
            if diningHall.name == "McMahon" {
                return "Dinner"
            } else {
                return "Between Meals"
            }
        }
        if (hour < 19 || (hour == 19 && minute < 15)) { return "Dinner" }
        if hour < 22, lateNightWeekdays.contains(weekday), lateNightDiningHalls.contains(diningHall.name) { return "Late Night" }
        return "CLOSED"
    }
}
