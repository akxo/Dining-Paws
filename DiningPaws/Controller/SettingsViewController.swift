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
    
    // use direct User. props instead?
    
    var locationEnabled: Bool! {
        didSet {
            if locationEnabled, homeEnabled {
                homeEnabled = false
                settingsTableView.reloadData()
            }
        }
    }
    
    var homeEnabled: Bool! {
        didSet {
            if homeEnabled, locationEnabled {
                locationEnabled = false
            }
            settingsTableView.reloadData()
        }
    }
    
    var homeDiningHall: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return UITableViewCell()
    }
}
