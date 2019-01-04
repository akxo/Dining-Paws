//
//  SearchResultTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/3/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let cellID = "searchResultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
