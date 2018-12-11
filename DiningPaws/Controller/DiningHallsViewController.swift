//
//  DiningHallsViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/10/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diningHallsTableView: UITableView!
    
    init() {
        super.init(nibName: "DiningHallsViewController", bundle: Bundle(for: DiningHallsViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        self.navigationItem.title = "Dining Halls"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .white
    }
}
