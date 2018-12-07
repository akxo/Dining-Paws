//
//  Campus.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Campus: NSCoding {

    let diningHalls: [DiningHall]
    var lastLoadDate: Date
    
    // MARK: init
    init(diningHalls: [DiningHall]) {
        self.diningHalls = diningHalls
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func updateCampus() {
        let today = Date()
        lastLoadDate = today
    }
    
}
