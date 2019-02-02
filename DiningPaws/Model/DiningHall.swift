//
//  DiningHall.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation
import CoreLocation

class DiningHall: NSObject, NSCoding {

    let name: String
    let locationNumber: String
    let locationName: String
    var days: [Day]
    var location: CLLocation
    
    // MARK: init
    init(name: String, locationNumber: String, locationName: String, days: [Day], location: CLLocation) {
        self.name = name
        self.locationNumber = locationNumber
        self.locationName = locationName
        self.days = days
        self.location = location
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(locationNumber, forKey: Key.locationNumber.rawValue)
        aCoder.encode(locationName, forKey: Key.locationName.rawValue)
        aCoder.encode(days, forKey: Key.days.rawValue)
        aCoder.encode(location, forKey: Key.location.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name.rawValue) as? String,
        let locationNumber = aDecoder.decodeObject(forKey: Key.locationNumber.rawValue) as? String,
        let locationName = aDecoder.decodeObject(forKey: Key.locationName.rawValue) as? String,
            let days = aDecoder.decodeObject(forKey: Key.days.rawValue) as? [Day],
            let location = aDecoder.decodeObject(forKey: Key.location.rawValue) as? CLLocation else { return nil }
        self.init(name: name, locationNumber: locationNumber, locationName: locationName, days: days, location: location)
    }
    
    private enum Key: String {
        case name = "name"
        case locationNumber = "locationNumber"
        case locationName = "locationName"
        case days = "days"
        case location = "location"
    }
    
    func day(for date: Date) -> Day? {
        return days.first(where: { $0.date.isEqual(to: date) })
    }
    
    func hasFavorite(on date: Date) -> Bool {
        guard let day = day(for: date) else { return false }
        for meal in day.meals {
            if meal.hasFavorite() { return true }
        }
        return false
    }
    
    func addDay(for date: Date, completion: (() -> Void)?) {
        guard let day = MenuClient.shared.day(for: date, at: self) else {
            completion?()
            return
        }
        days.append(day)
        completion?()
    }
}
