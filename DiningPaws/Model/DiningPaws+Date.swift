//
//  DiningPaws+Date.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/10/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

extension Date {
    
    var month: String {
        return String(Calendar.current.component(.month, from: self))
    }
    
    var day: String {
        return String(Calendar.current.component(.day, from: self))
    }
    
    var year: String {
        return String(Calendar.current.component(.year, from: self))
    }
    
    var weekday: String {
        return String(Calendar.current.component(.weekday, from: self))
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var description: String {
        let today = Date()
        if self.isEqual(to: today) { return "Today" }
        if self.isEqual(to: Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()) { return "Tomorrow" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func isEqual(to date: Date) -> Bool {
        guard self.month == date.month, self.day == date.day, self.year == date.year else { return false }
        return true
    }
    
    func  isLess(than date: Date) -> Bool {
        let order = Calendar.current.compare(self, to: date, toGranularity: .day)
        return order == .orderedAscending
    }
}
