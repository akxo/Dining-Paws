//
//  FavoritesSectionCell.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/17/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class FavoritesSectionCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .chalkboardBold20
        label.textColor = UConn.primaryColor
        label.text = "Favorites"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (3 / 4) * UIScreen.main.bounds.width, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: (1 / 14) * UIScreen.main.bounds.width, bottom: 0, right: (1 / 14) * UIScreen.main.bounds.width)
        layout.minimumLineSpacing = (1 / 28) * UIScreen.main.bounds.width
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
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
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (1 / 14) * UIScreen.main.bounds.width).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
        
        self.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .sixteen).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.identifier)
    }
}

// MARK: - CollectionView Data Source

extension FavoritesSectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.identifier, for: indexPath)
        return cell
    }
}
