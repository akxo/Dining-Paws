//
//  Day.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Day: NSObject, NSCoding {
    
    let date: Date
    let meals: [Meal]

    // MARK: init
    init(date: Date, meals: [Meal]) {
        self.date = date
        self.meals = meals
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: Key.date.rawValue)
        aCoder.encode(meals, forKey: Key.meals.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObject(forKey: Key.date.rawValue) as? Date,
            let meals = aDecoder.decodeObject(forKey: Key.meals.rawValue) as? [Meal] else { return nil }
        self.init(date: date, meals: meals)
    }
    
    private enum Key: String {
        case date = "date"
        case meals = "meals"
    }
    
    func index(for mealName: String) -> Int? {
         let index = meals.firstIndex(where: { $0.name == mealName })
        if index != nil { return index }
        if mealName == "Brunch" { return meals.firstIndex(where: { $0.name == "Lunch" }) }
        return nil
    }
}
