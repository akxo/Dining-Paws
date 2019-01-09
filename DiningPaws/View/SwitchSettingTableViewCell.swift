//
//  SwitchSettingTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/8/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class SwitchSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    static let cellID = "switchSettingTableViewCell"
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
