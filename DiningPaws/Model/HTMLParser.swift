//
//  HTMLParser.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class HTMLParser {
    
    static let shared = HTMLParser()
    
    public func meals(for html: String) -> [Meal] {
        guard !html.isEmpty else { return [] }
        var meals = [Meal]()
        var mealComponents = html.components(separatedBy: "<div class=\"shortmenumeals\">")
        mealComponents.removeFirst()
        for mealHTML in mealComponents {
            let name = mealHTML.components(separatedBy: "</div>").first ?? "Meal"
            let mealStations = stations(for: mealHTML)
            let meal = Meal(name: name, stations: mealStations)
            meals.append(meal)
            
            // handle late night
            guard name == "Dinner" else { continue }
            var lateNightHTML = mealHTML.components(separatedBy: "-- LATE NIGHT --")
            guard lateNightHTML.count > 1 else { continue }
            lateNightHTML = lateNightHTML[1].components(separatedBy: "shortmenucats")
            let lateNightStations = [Station(name: "LATE NIGHT", options: options(for: lateNightHTML[0]))]
            let lateNight = Meal(name: "Late Night", stations: lateNightStations)
            meals.append(lateNight)
        }
        return meals
    }
    
    public func stations(for html: String) -> [Station] {
        guard !html.isEmpty else { return [] }
        var stations = [Station]()
        var stationComponents = html.components(separatedBy: "<div class=\"shortmenucats\"><span style=\"color: #000000\">-- ")
        stationComponents.removeFirst()
        for stationHTML in stationComponents {
            let name = stationHTML.components(separatedBy: " --").first ?? "STATION"
            guard name != "LATE NIGHT" else { continue }
            let stationOptions = options(for: stationHTML)
            let station = Station(name: name, options: stationOptions)
            stations.append(station)
        }
        return stations
    }
    
    public func options(for html: String) -> [String] {
        guard !html.isEmpty else { return [] }
        var options = [String]()
        var optionComponents = html.components(separatedBy: "<div class='shortmenurecipes'><span style='color: #000000'>")
        optionComponents.removeFirst()
        for optionHTML in optionComponents {
            let option = optionHTML.components(separatedBy: "&nbsp;").first ?? "Option"
            options.append(option)
        }
        return options
    }
}
