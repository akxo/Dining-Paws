//
//  Meal.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding {
    
    let name: String
    let stations: [Station]
    
    // MARK: init
    init(name: String, stations: [Station]) {
        self.name = name
        self.stations = stations
    }
    
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(stations, forKey: Key.stations.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name.rawValue) as? String,
            let stations = aDecoder.decodeObject(forKey: Key.stations.rawValue) as? [Station] else { return nil }
        self.init(name: name, stations: stations)
    }
    
    private enum Key: String {
        case name = "name"
        case stations = "stations"
    }
    
    func hasFavorite() -> Bool {
        for station in stations {
            for option in station.options {
                if User.currentUser.enabledFavorites.contains(where: { option.contains($0) }) { return true }
            }
        }
        return false
    }
}
