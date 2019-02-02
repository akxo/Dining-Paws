//
//  SettingsViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 1/7/19.
//  Copyright © 2019 Aktrapp. All rights reserved.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    let locationManager = CLLocationManager()
    
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
        let headerFooterCellNib = UINib(nibName: "SettingHeaderFooterCell", bundle: nil)
        self.settingsTableView.register(headerFooterCellNib, forCellReuseIdentifier: SettingHeaderFooterCell.cellID)
    }
    
    // MARK: table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 0 }
        if section == 3 { return 8 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 { return 33 }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: SettingHeaderFooterCell.cellID) as? SettingHeaderFooterCell else { return nil }
        if section == 3 {
            header.headerLabel.text = "HOME DINING HALL:"
            return header
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let smallScreenAddition: CGFloat = UIScreen.main.bounds.width == 320 ? 10 : 0
        if section == 0 { return 30 - smallScreenAddition }
        if section == 1 { return 70 + (smallScreenAddition * 2) }
        if section == 2 { return 50 + smallScreenAddition }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableCell(withIdentifier: SettingHeaderFooterCell.cellID) as? SettingHeaderFooterCell else { return nil }
        if section == 1 {
            footer.footerLabel.text = "Enabling location loading will show you the menu for the closest dining hall to your current location when the app is launched."
        } else if section == 2 {
            footer.footerLabel.text = "Enabling home loading will show you the menu for your home dining hall when the app is launched."
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchSettingTableViewCell.cellID, for: indexPath) as? SwitchSettingTableViewCell else { return UITableViewCell() }
        if indexPath.section == 1 {
            cell.settingLabel.text = "Location loading:"
            cell.settingSwitch.isOn = User.currentUser.locationBasedLoadIsEnabled
            cell.selectionStyle = .none
            cell.toggled = { value in
                if !value || self.checkLocationAuthorization() {
                    User.currentUser.setLocationBasedLoading(to: value)
                }
                self.settingsTableView.reloadData()
            }
        } else if indexPath.section == 2 {
            cell.settingLabel.text = "Home loading:"
            cell.settingSwitch.isOn = User.currentUser.homeDiningHall != nil
            cell.selectionStyle = .none
            cell.toggled = { value in
                let homeDiningHall = value ? UConn.diningHalls.first : nil
                User.currentUser.setHomeDiningHall(to: homeDiningHall)
                self.settingsTableView.reloadData()
            }
        } else {
            let diningHall = UConn.diningHalls[indexPath.row]
            cell.settingLabel.text = diningHall
            cell.settingSwitch.isHidden = true
            cell.accessoryType = User.currentUser.homeDiningHall == diningHall ? .checkmark : .none
            cell.isEnabled = User.currentUser.homeDiningHall != nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 3 else { return }
        let selectedDiningHall = UConn.diningHalls[indexPath.row]
        User.currentUser.setHomeDiningHall(to: selectedDiningHall)
        settingsTableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: location method
    private func checkLocationAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return true
        case .denied:
            let deniedAlert = UIAlertController(title: "Location authorization denied", message: "Go to settings and allow Dining Paws to use your location to access this feature.", preferredStyle: .alert)
            deniedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            deniedAlert.addAction(UIAlertAction(title: "Go To Settings", style: .default, handler: { (_) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }
            }))
            self.present(deniedAlert, animated: true, completion: nil)
            return false
        case .restricted:
            let restrictedAlert = UIAlertController(title: "Location authorization restricted", message: "Parental controls may be blocking location services.", preferredStyle: .alert)
            restrictedAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(restrictedAlert, animated: true, completion: nil)
            return false
        }
    }
}
