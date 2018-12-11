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
    
    func isEqualTo(_ date: Date) -> Bool {
        guard self.month == date.month, self.day == date.day, self.year == date.year else { return false }
        return true
    }
}
