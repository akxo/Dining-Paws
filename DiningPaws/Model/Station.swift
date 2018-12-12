//
//  Station.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Station: NSObject, NSCoding {
    
    let name: String
    let options: [String]

    // MARK: init
    init(name: String, options: [String]) {
        self.name = name
        self.options = options
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(options, forKey: Key.options.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name.rawValue) as? String,
            let options = aDecoder.decodeObject(forKey: Key.options.rawValue) as? [String] else { return nil }
        self.init(name: name, options: options)
    }
    
    private enum Key: String {
        case name = "name"
        case options = "options"
    }
    
}
