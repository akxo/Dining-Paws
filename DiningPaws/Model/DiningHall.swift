//
//  DiningHall.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class DiningHall: NSCoding {

    let name: String
    let locationName: String
    let locationNumber: String
    var days: [Day]
    
    // MARK: init
    init(name: String, locationName: String, locationNumber: String, days: [Day]) {
        self.name = name
        self.locationName = locationName
        self.locationNumber = locationNumber
        self.days = days
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
}
