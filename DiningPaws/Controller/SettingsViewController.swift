//
//  SettingsViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/7/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var locationEnabled: Bool! {
        didSet {
            if locationEnabled, homeEnabled {
                homeEnabled = false
                if settingsTableView != nil { settingsTableView.reloadData() }
            }
            User.currentUser.locationBasedLoadIsEnabled = locationEnabled
        }
    }
    
    var homeEnabled: Bool! {
        didSet {
            if homeEnabled, locationEnabled {
                locationEnabled = false
            }
            homeDiningHall = homeEnabled ? "Buckley" : nil
            if settingsTableView != nil { settingsTableView.reloadData() }
        }
    }
    
    var homeDiningHall: String? {
        didSet {
            User.currentUser.homeDiningHall = homeDiningHall
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: initial setup
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        let tableViewCellNib = UINib(nibName: "SwitchSettingTableViewCell", bundle: nil)
        self.settingsTableView.register(tableViewCellNib, forCellReuseIdentifier: SwitchSettingTableViewCell.cellID)
    }
    
    // MARK: table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if homeEnabled { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchSettingTableViewCell.cellID, for: indexPath) as? SwitchSettingTableViewCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.settingLabel.text = "Location loading:"
            cell.settingSwitch.isOn = locationEnabled
        } else {
            cell.settingLabel.text = "Home loading:"
            cell.settingSwitch.isOn = homeEnabled
        }
        return cell
    }
}
