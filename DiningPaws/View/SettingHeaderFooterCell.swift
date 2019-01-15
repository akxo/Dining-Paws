//
//  SettingHeaderFooterCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/14/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class SettingHeaderFooterCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    
    static let cellID = "settingHeaderFooterLabel"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        headerLabel.text = ""
        footerLabel.text = ""
    }
}
