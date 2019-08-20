//
//  Campus.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Campus: NSObject, NSCoding {

    let schoolName: String
    var diningHalls: [DiningHall]
    var lastLoadDate: Date?
    
    var allOptions: [SearchResult] {
        return getAllOptions()
    }
    
    // MARK: init
    override init() {
        self.schoolName = "UConn"
        self.diningHalls = UConn.initializeNewDiningHalls()
    }
    
    init(schoolName: String, diningHalls: [DiningHall], lastLoadDate: Date) {
        self.schoolName = schoolName
        self.diningHalls = diningHalls
        self.lastLoadDate = lastLoadDate
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(schoolName, forKey: Key.schoolName.rawValue)
        aCoder.encode(diningHalls, forKey: Key.diningHalls.rawValue)
        aCoder.encode(lastLoadDate, forKey: Key.lastLoadDate.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let schoolName = aDecoder.decodeObject(forKey: Key.schoolName.rawValue) as? String,
        let diningHalls = aDecoder.decodeObject(forKey: Key.diningHalls.rawValue) as? [DiningHall],
            let lastLoadDate = aDecoder.decodeObject(forKey: Key.lastLoadDate.rawValue) as? Date else { return nil }
        self.init(schoolName: schoolName, diningHalls: diningHalls, lastLoadDate: lastLoadDate)
    }
    
    private enum Key: String {
        case schoolName = "schoolName"
        case diningHalls = "diningHalls"
        case lastLoadDate = "lastLoadDate"
    }
    
    func cleanUp() {
        let today = Date()
        guard !(lastLoadDate?.isEqual(to: today) ?? false) else { return }
        
        for diningHall in diningHalls {
            var newDaysDict = [String : Day]()
            
            for (dateId, day) in diningHall.days {
                if let date = Date(from: dateId), date.isEqual(to: today) || today.isLess(than: date) {
                    newDaysDict[date.id] = day
                }
            }
            
            diningHall.days = newDaysDict
        }
    }
    
    func addDay(for date: Date, completion: (() -> Void)?) {
        for diningHall in diningHalls {
            guard diningHall.days[date.id] == nil else { continue }
            guard let nextDay = MenuClient.shared.day(for: date, at: diningHall) else {
                completion?()
                return
            }
            diningHall.days[date.id] = nextDay
        }
        lastLoadDate = Date()
        save()
        completion?()
    }
    
    func save() {
        do {
            let campusData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(campusData, forKey: "campusData")
        } catch let error {
            print("error: \(error)")
        }
    }
    
    func removeData() {
        UserDefaults.standard.set(nil, forKey: "campusData")
    }
    
    private func getAllOptions() -> [SearchResult] {
        var results = [SearchResult]()
        for (diningHallIndex, diningHall) in diningHalls.enumerated() {
            for (dateId, day) in diningHall.days {
                guard let date = Date(from: dateId) else { continue }
                for (mealIndex, meal) in day.meals.enumerated() {
                    for station in meal.stations {
                        for option in station.options {
                            let result = SearchResult(name: option, diningHall: diningHall.name, date: date, meal: meal.name, diningHallIndex: diningHallIndex, mealIndex: mealIndex)
                            results.append(result)
                        }
                    }
                }
            }
        }
        return results.sorted(by: { (val1, val2) in
            if val1.date == nil || val2.date == nil { return false }
            return val1.date!.isLess(than: val2.date!)
        })
    }
    
}
