//
//  CGFloat+Additions.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/17/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static var ten: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return 2
        } else if screenHeight < 737 {
            return 8
        }
        return 10
    }
    
    static var sixteen: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return 8
        } else if screenHeight < 737 {
            return 12
        }
        return 16
    }
    
    static var twentyFive: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return 5
        } else if screenHeight < 737 {
            return 15
        }
        return 25
    }
    
    static var fifty: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 737 {
            return 25
        }
        return 50
    }
    
    static var oneFifteen: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return 75
        } else if screenHeight < 737 {
            return 80
        }
        return 115
    }
    
    static var itemSpacing: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return (1 / 25)
        }
        return (1 / 14)
    }
    
    static var menuSectionHeight: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        if screenHeight < 668 {
            return 400
        }
        return 700
    }
}
