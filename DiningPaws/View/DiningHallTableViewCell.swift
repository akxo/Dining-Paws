//
//  DiningHallTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/11/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noStatusNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    static let cellID = "diningHallTableViewCell"
    var date: Date!
    var diningHall: DiningHall! {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if !date.isEqual(to: Date()) {
            noStatusNameLabel.text = diningHall.name
        } else {
            noStatusNameLabel.text = ""
            nameLabel.text = diningHall.name
            statusLabel.text = UConn.status(for: diningHall, on: date) /* maybe do another check for specific meals */
            statusLabel.textColor = statusLabel.text == "CLOSED" ? UIColor.red : UIColor.black
        }
        favoriteImage.isHidden = !diningHall.hasFavorite(on: date)
    }
    
    override func awakeFromNib() {
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        noStatusNameLabel.text = ""
        nameLabel.text = ""
        statusLabel.text = ""
        favoriteImage.isHidden = true
        networkErrorLabel.isHidden = true
    }
    
}
