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
    
    func loadToday() {
        let today = Date()
        guard !(lastLoadDate?.isEqual(to: today) ?? false) else { return }
        
        for diningHall in diningHalls {
            while !diningHall.days.isEmpty, !diningHall.days.first!.date.isEqual(to: today) {
                diningHall.days.removeFirst()
            }
        }
        if diningHalls.first?.days.isEmpty ?? true {
            self.addDay(for: today, completion: nil)
        }
        guard !(lastLoadDate?.isEqual(to: today) ?? false) else { return }
        lastLoadDate = today
        save()
    }
    
    func cleanUp() {
        let today = Date()
        guard !(lastLoadDate?.isEqual(to: today) ?? false) else { return }
        
        for diningHall in diningHalls {
            while !diningHall.days.isEmpty, !diningHall.days.first!.date.isEqual(to: today) {
                diningHall.days.removeFirst()
            }
        }
    }
    
    func addDay(for date: Date, completion: (() -> Void)?) {
        for diningHall in diningHalls {
            guard !diningHall.days.contains(where: { $0.date.isEqual(to: date) }) else { continue }
            let nextDay = MenuClient.shared.day(for: date, at: diningHall)
            diningHall.days.append(nextDay)
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
    
}
