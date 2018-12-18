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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
