//
//  SearchTableViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/23/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var campus: Campus!
    var allOptions: [SearchResult]!
    var filteredOptions: [SearchResult] = []
    var resultSelected: ((SearchResult)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    // initial setup
    private func setupTableView() {
        allOptions = campus.allOptions
        let tableViewCellNib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: SearchResultTableViewCell.cellID)
        tableView.rowHeight = 85
    }
    
    private func reloadTableView() {
        allOptions = campus.allOptions
        filteredOptions = allOptions
        tableView.reloadData()
    }
    
    // search update method
    func updateSearchResults(for text: String?) {
        if let text = text {
            filteredOptions = allOptions.filter({ $0.name.lowercased().contains(text) })
        } else {
            filteredOptions = []
        }
        tableView.reloadData()
    }
    
    // MARK: table view methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellID, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.nameLabel?.text = filteredOptions[indexPath.row].name
        cell.subtitleLabel?.text = filteredOptions[indexPath.row].subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = filteredOptions[indexPath.row]
        resultSelected?(result)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
