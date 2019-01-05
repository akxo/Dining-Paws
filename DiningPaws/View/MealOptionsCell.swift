//
//  MealOptionsCell.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/17/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class MealOptionsCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var optionsTableView: UITableView!
    
    static let cellID = "mealOptionsCell"
    var meal: Meal! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        let optionsTableViewCellNib = UINib(nibName: "OptionTableViewCell", bundle: nil)
        optionsTableView.register(optionsTableViewCellNib, forCellReuseIdentifier: OptionTableViewCell.cellID)
    }
    
    // MARK: table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return meal.stations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.stations[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meal.stations[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.cellID, for: indexPath) as? OptionTableViewCell else { return UITableViewCell() }
        let option = meal.stations[indexPath.section].options[indexPath.row]
        cell.optionLabel.text = option
        cell.favoriteImageView.isHidden = !User.currentUser.enabledFavorites.contains(where: { option.contains($0) })
        return cell
    }
}
