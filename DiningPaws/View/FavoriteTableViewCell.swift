//
//  FavoriteTableViewCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/15/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    static let cellID = "favoriteTableViewCell"
    var favorite: String! {
        didSet {
            nameLabel.text = favorite
        }
    }
    var isEnabled: Bool! {
        didSet {
            statusImage.image = isEnabled ? UIImage(named: "filledStar") : UIImage(named: "unfilledStar")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
    }
    
    override func prepareForReuse() {
        emptyLabel.isHidden = true
        nameLabel.isHidden = false
        statusImage.isHidden = false
        self.isUserInteractionEnabled = true
    }
}
