//
//  UConn.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/8/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

struct UConn {
    
    static func initializeNewDiningHalls() -> [DiningHall] {
        let buckley = DiningHall(name: "Buckley", locationNumber: "03", locationName: "Buckley+Dining+Hall", days: [])
        let mcmahon = DiningHall(name: "McMahon", locationNumber: "05", locationName: "McMahon+Dining+Hall", days: [])
        let north = DiningHall(name: "North", locationNumber: "07", locationName: "North+Campus+Dining+Hall", days: [])
        let northwest = DiningHall(name: "Northwest", locationNumber: "15", locationName: "Northwest+Marketplace", days: [])
        let putnam = DiningHall(name: "Putnam", locationNumber: "06", locationName: "Putnam+Dining+Hall", days: [])
        let south = DiningHall(name: "South", locationNumber: "16", locationName: "South+Campus+Marketplace", days: [])
        let towers = DiningHall(name: "Towers", locationNumber: "42", locationName: "Gelfenbien+Commons+%26+Halal", days: [])
        let whitney = DiningHall(name: "Whitney", locationNumber: "01", locationName: "Whitney+Dining+Hall", days: [])
        return [buckley, mcmahon, north, northwest, putnam, south, towers, whitney]
    }
}
