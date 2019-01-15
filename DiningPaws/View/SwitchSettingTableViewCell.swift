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
    
    var toggled: ((Bool)->Void)?
    
    var isEnabled: Bool! {
        didSet {
            isUserInteractionEnabled = isEnabled
            settingLabel.textColor = isEnabled ? UIColor.darkText : .gray
        }
    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        toggled?(sender.isOn)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        settingSwitch.isHidden = false
        isEnabled = true
    }
}
