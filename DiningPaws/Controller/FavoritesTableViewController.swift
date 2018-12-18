//
//  FavoritesTableViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/15/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var favorites: [String] {
        return User.currentUser.favorites
    }
    var enabledFavorites: Set<String> {
        return User.currentUser.enabledFavorites
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    // MARK: initial setup
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.barTintColor = UConn.primaryColor
        self.navigationController?.navigationBar.tintColor = .white
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        let tableViewCellNib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.tableView.register(tableViewCellNib, forCellReuseIdentifier: FavoriteTableViewCell.cellID)
    }
    
    // MARK: table view methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.cellID) as? FavoriteTableViewCell else { return UITableViewCell() }
        let favorite = favorites[indexPath.row]
        cell.favorite = favorite
        cell.isEnabled = enabledFavorites.contains(favorite)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell, let favorite = cell.favorite {
            User.currentUser.changeStatus(for: favorite)
            cell.isEnabled = !cell.isEnabled
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell, let favorite = cell.favorite {
                User.currentUser.remove(favorite)
                self.tableView.reloadData()
            }
        }
    }

    @objc private func addButtonTapped() {
        let addFavoriteAlert = UIAlertController(title: "Add Favorite", message: "", preferredStyle: .alert)
        addFavoriteAlert.addTextField(configurationHandler: nil)
        addFavoriteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        addFavoriteAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak addFavoriteAlert] (_) in
            if let favorite = addFavoriteAlert?.textFields?.first?.text {
                User.currentUser.add(favorite)
                self.tableView.reloadData()
            }
        }))
        self.present(addFavoriteAlert, animated: true, completion: nil)
    }
    
}
