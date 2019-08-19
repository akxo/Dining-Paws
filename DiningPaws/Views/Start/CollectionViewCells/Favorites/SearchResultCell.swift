//
//  SearchResultCell.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/18/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "Zesty Fried Chicken Tenders"
        label.font = .chalkboardRegular18
        return label
    }()
    
    let favoriteImageView: UIImageView = {
        let image = UIImage(named: "filledStar")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Today"
        label.font = .chalkboardLight15
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Northwest"
        label.font = .chalkboardLight15
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UConn.primaryColor
        return view
    }()
    
    let mealLabel: UILabel = {
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
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        
        self.addSubview(favoriteImageView)
        favoriteImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        favoriteImageView.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 5).isActive = true
        favoriteImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        favoriteImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        favoriteImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        
        self.addSubview(divider)
        divider.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor, constant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 7).isActive = true
        divider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        self.addSubview(mealLabel)
        mealLabel.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor).isActive = true
        mealLabel.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 7).isActive = true
        mealLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12).isActive = true
        
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
    }
}
