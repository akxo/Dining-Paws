//
//  DaySectionCell.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/17/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class DaySectionCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    lazy var itemWidth = (11 / 28) * self.frame.width
    lazy var itemHeight: CGFloat = 70
    lazy var itemSpacing = .itemSpacing * self.frame.width
    lazy var sectionSpacing = (1 / 14) * self.frame.width
    
    // MARK: - UI Components
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .chalkboardRegular18
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "Today"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 5, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        design()
        applyConstraints()
        registerCollectionViewCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func design() {
        backgroundColor = .clear
    }
    
    private func applyConstraints() {
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .ten).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(DiningHallCell.self, forCellWithReuseIdentifier: DiningHallCell.identifier)
    }
}

// MARK: - CollectionView Data Source

extension DaySectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiningHallCell.identifier, for: indexPath)
        return cell
    }
}
