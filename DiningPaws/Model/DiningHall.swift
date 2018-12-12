//
//  DiningHall.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class DiningHall: NSObject, NSCoding {

    let name: String
    let locationNumber: String
    let locationName: String
    var days: [Day]
    
    // MARK: init
    init(name: String, locationNumber: String, locationName: String, days: [Day]) {
        self.name = name
        self.locationNumber = locationNumber
        self.locationName = locationName
        self.days = days
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(locationNumber, forKey: Key.locationNumber.rawValue)
        aCoder.encode(locationName, forKey: Key.locationName.rawValue)
        aCoder.encode(days, forKey: Key.days.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name.rawValue) as? String,
        let locationNumber = aDecoder.decodeObject(forKey: Key.locationNumber.rawValue) as? String,
        let locationName = aDecoder.decodeObject(forKey: Key.locationName.rawValue) as? String,
            let days = aDecoder.decodeObject(forKey: Key.days.rawValue) as? [Day] else { return nil }
        self.init(name: name, locationNumber: locationNumber, locationName: locationName, days: days)
    }
    
    private enum Key: String {
        case name = "name"
        case locationNumber = "locationNumber"
        case locationName = "locationName"
        case days = "days"
    }
}
