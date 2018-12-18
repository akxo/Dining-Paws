//
//  OptionTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/17/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    
    static let cellID = "optionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
    }
    
}
