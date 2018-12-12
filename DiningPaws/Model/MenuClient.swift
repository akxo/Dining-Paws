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
        urlString += "locationNum=" + diningHall.locationNumber
        urlString += "&locationName=" + diningHall.locationName + "&naFlag=1"
        if !date.isEqualTo(Date()) {
            urlString += "&WeeksMenus=This+Week%27s+Menus&myaction=read&dtdate=" + date.month + "%2f" + date.day + "%2f" + date.year
        }
        
        var html = ""
        if let url = URL(string: urlString) {
            do {
                html = try String(contentsOf: url)
                
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        }
        let meals = HTMLParser.shared.meals(for: html)
        return Day(date: date, meals: meals)
    }



}
