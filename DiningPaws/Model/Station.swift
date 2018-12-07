//
//  Station.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class Station: NSCoding {
    
    let name: String
    let options: [String]

    // MARK: init
    init(name: String, options: [String]) {
        self.name = name
        self.options = options
    }
    
    // MARK: persistence
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    
}
