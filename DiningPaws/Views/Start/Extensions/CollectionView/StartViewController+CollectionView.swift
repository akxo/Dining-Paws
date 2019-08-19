//
//  StartViewController+CollectionView.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/15/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

// MARK: - CollectionView Sections

enum StartCollectionViewSection: Int {
    case favorites
    case menu
}

// MARK: - CollectionView Data Source

extension StartViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        
        switch indexPath.section {
        case StartCollectionViewSection.favorites.rawValue:
            cell = favoritesSectionCell(for: collectionView, at: indexPath)
        case StartCollectionViewSection.menu.rawValue:
            cell = menuSectionCell(for: collectionView, at: indexPath)
        default:
            break
        }
        return cell
    }
    
    // MARK: - Cell Builder
    
    private func favoritesSectionCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> FavoritesSectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesSectionCell.identifier, for: indexPath) as! FavoritesSectionCell
        cell.backgroundColor = .clear
        return cell
    }
    
    private func menuSectionCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> MenuSectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCell.identifier, for: indexPath) as! MenuSectionCell
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - CollectionView Delegate Flow Layout

extension StartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat
        
        switch indexPath.section {
        case StartCollectionViewSection.favorites.rawValue:
            height = 128
        case StartCollectionViewSection.menu.rawValue:
            height = .menuSectionHeight
        default:
            height = 0
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
