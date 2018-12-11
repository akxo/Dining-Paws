//
//  Campus.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Campus: NSCoding {

    let schoolName: String
    var diningHalls: [DiningHall]
    var lastLoadDate: Date
    
    // MARK: init
    init() {
        self.schoolName = "UConn"
        self.diningHalls = UConn.initializeNewDiningHalls()
        self.lastLoadDate = Date()
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
    
    func updateCampus() {
        let today = Date()
        guard !lastLoadDate.isEqualTo(today) else { return }
        
        for diningHall in diningHalls {
            while !diningHall.days.isEmpty, !diningHall.days.first!.date.isEqualTo(today) {
                diningHall.days.removeFirst()
            }
        }
        for i in 0..<3 {
            guard let nextDate = Calendar.current.date(byAdding: .day, value: i, to: today) else { return }
            for diningHall in diningHalls {
                guard i >= diningHall.days.count else { break }
                let nextDay = MenuClient.shared.day(for: nextDate, at: diningHall)
                diningHall.days.append(nextDay)
            }
        }
        lastLoadDate = today
        save()
    }
    
    func save() {
        do {
            let campusData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(campusData, forKey: "campusData")
        } catch let error {
            print("error: \(error)")
        }
    }
    
}
