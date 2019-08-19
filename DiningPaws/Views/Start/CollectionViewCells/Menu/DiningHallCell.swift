//
//  DiningHallCell.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/18/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "Northwest"
        label.font = .chalkboardRegular18
        return label
    }()
    
    let favoriteImageView: UIImageView = {
        let image = UIImage(named: "filledStar")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Lunch"
        label.font = .chalkboardLight15
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        design()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func design() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
    }
    
    private func applyConstraints() {
        self.addSubview(nameLabel)
        nameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        
        self.addSubview(favoriteImageView)
        favoriteImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 2).isActive = true
        favoriteImageView.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 5).isActive = true
        favoriteImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        favoriteImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
    }
}
