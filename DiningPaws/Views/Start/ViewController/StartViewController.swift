//
//  StartViewController.swift
//  DiningPaws
//
//  Created by Alex Kerendian on 8/15/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // UI Components
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        let image = UIImage(named: "settings")
        button.setImage(image, for: .normal)
        button.tintColor = UConn.primaryColor
        return button
    }()
    
    let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        let image = UIImage(named: "filledStar")
        button.setImage(image, for: .normal)
        button.tintColor = UConn.primaryColor
        return button
    }()
    
    let imageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 1
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .init(x: (1 / 8) * UIScreen.main.bounds.width, y: .oneFifteen, width: (3 / 4) * UIScreen.main.bounds.width, height: 44))
        
        searchBar.placeholder = "Try \"chicken tenders\""
        searchBar.tintColor = .gray
        searchBar.backgroundImage = UIImage()
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.2
        searchBar.layer.shadowOffset = .zero
        searchBar.layer.shadowRadius = 4
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = UIScreen.main.bounds.height < 678
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
        applyConstraints()
        registerCollectionViewCells()
    }
    
    private func design() {
        view.backgroundColor = .gray99
    }
    
    private func applyConstraints() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: .fifty).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 2).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        view.addSubview(favoritesButton)
        favoritesButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        favoritesButton.widthAnchor.constraint(equalToConstant: 21).isActive = true
        favoritesButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(searchBar)
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: .twentyFive).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(FavoritesSectionCell.self, forCellWithReuseIdentifier: FavoritesSectionCell.identifier)
        collectionView.register(MenuSectionCell.self, forCellWithReuseIdentifier: MenuSectionCell.identifier)
    }
    
    // MARK: - Actions
    
    @objc private func settingsButtonTapped() {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    @objc private func favoritesButtonTapped() {
        
    }
}

extension StartViewController: UISearchBarDelegate {
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = true
            searchBar.frame = .init(x: (1 / 20) * UIScreen.main.bounds.width, y: .oneFifteen, width: (9 / 10) * UIScreen.main.bounds.width, height: 44)
        }
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = false
            searchBar.frame = .init(x: (1 / 8) * UIScreen.main.bounds.width, y: .oneFifteen, width: (3 / 4) * UIScreen.main.bounds.width, height: 44)
            searchBar.resignFirstResponder()
        }
    }
}
