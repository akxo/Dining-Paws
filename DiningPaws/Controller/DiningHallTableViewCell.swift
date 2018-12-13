//
//  DiningHallTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/11/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    static let cellID = "DiningHallCellID"
    var diningHall: DiningHall! {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        nameLabel.text = diningHall.name
        statusLabel.text = UConn.status(for: diningHall)
        statusLabel.textColor = statusLabel.text == "CLOSED" ? UIColor.red : UIColor.darkGray
        favoriteImage.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
