//
//  MealSelectionBarCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/16/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class MealSelectionBarCell: UICollectionViewCell {

    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    static let cellID = "mealSelectionBarCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        favoriteImageView.isHidden = true
    }
    
    override func prepareForReuse() {
        mealNameLabel.textColor = UConn.secondaryColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                mealNameLabel.textColor = UConn.primaryColor
                mealNameLabel.font = UIFont.boldSystemFont(ofSize: mealNameLabel.font.pointSize)
            } else {
                mealNameLabel.textColor = UConn.secondaryColor
                mealNameLabel.font = UIFont.systemFont(ofSize: mealNameLabel.font.pointSize)
            }
        }
    }
}
