//
//  MenuClient.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class MenuClient {
    
    let baseURLString = "http://nutritionanalysis.dds.uconn.edu/shortmenu.aspx?sName=UCONN+Dining+Services&"
    static let shared = MenuClient()
    
    func day(for date: Date, at diningHall: DiningHall) -> Day {
        var urlString = baseURLString
        
        // TODO: create url based on dining hall and date
        
        return urlString
    }
    
    
    
}
