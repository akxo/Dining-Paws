//
//  Meal.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Meal: NSCoding {
    
    let name: String
    let stations: [Station]
    
    // MARK: init
    init(name: String, stations: [Station]) {
        self.name = name
        self.stations = stations
    }
    
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    
}
