//
//  Day.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Day: NSCoding {
    
    let date: Date
    let meals: [Meal]

    // MARK: init
    init(date: Date, meals: [Meal]) {
        self.date = date
        self.meals = meals
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    
}
