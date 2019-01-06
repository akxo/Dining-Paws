//
//  MealOptionsCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/17/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class MealOptionsCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noFoodView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    
    static let cellID = "mealOptionsCell"
    var meal: Meal! = nil
    var searchText: String?
    var filteredStations: [Station] = []
    
    var isSearching: Bool {
        guard let searchText = self.searchText, !searchText.isEmpty else { return false }
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        let optionsTableViewCellNib = UINib(nibName: "OptionTableViewCell", bundle: nil)
        optionsTableView.register(optionsTableViewCellNib, forCellReuseIdentifier: OptionTableViewCell.cellID)
        optionsTableView.rowHeight = 85
    }
    
    func configure() {
        noFoodView.isHidden = !meal.stations.isEmpty
        if let searchText = self.searchText?.lowercased(), !searchText.isEmpty {
            filteredStations = filter(with: searchText)
        } else {
            filteredStations = meal.stations
        }
        optionsTableView.reloadData()
    }
    
    func filter(with text: String) -> [Station] {
        var stations = [Station]()
        for station in meal.stations {
            var options = [String]()
            for option in station.options {
                if option.lowercased().contains(text) {
                    options.append(option)
                }
            }
            if !options.isEmpty {
                let filteredStation = Station(name: station.name, options: options)
                stations.append(filteredStation)
            }
        }
        return stations
    }
    
    // MARK: table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredStations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStations[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredStations[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.cellID, for: indexPath) as? OptionTableViewCell else { return UITableViewCell() }
        let option = filteredStations[indexPath.section].options[indexPath.row]
        cell.optionLabel.text = option
        cell.favoriteImageView.isHidden = !User.currentUser.enabledFavorites.contains(where: { option.lowercased().contains($0.lowercased()) })
        return cell
    }
}
