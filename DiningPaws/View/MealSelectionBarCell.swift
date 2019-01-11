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
    @IBOutlet weak var favoriteImageWidth: NSLayoutConstraint!
    @IBOutlet weak var favoriteImageHeight: NSLayoutConstraint!
    
    static let cellID = "mealSelectionBarCell"
    var screenSize: CGFloat! {
        didSet {
            var pointSize: CGFloat = 17.0
            var imageSize: CGFloat = 12.0
            if screenSize == 320 {
                pointSize = 12.0
                imageSize = 10.0
            } else if screenSize < 400 {
                pointSize = 15.0
                imageSize = 11.0
            }
            mealNameLabel.font = UIFont.systemFont(ofSize: pointSize)
            favoriteImageWidth.constant = imageSize
            favoriteImageHeight.constant = imageSize
        }
    }
    
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
