//
//  DayViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/10/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diningHallsTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let diningHallCellID = "diningHallCellID"
    
    var campus: Campus!
    var date: Date
//    var index: Int
    
    init(date: Date) {
        self.date = date
        super.init(nibName: "DayViewController", bundle: Bundle(for: DayViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: view life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshControl = UIRefreshControl()
        diningHallsTableView.addSubview(refreshControl)
        diningHallsTableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl.frame.size.height)
        refreshControl.beginRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: check if campus has a day with date or index and add day if not
        refreshControl.endRefreshing()
    }
    
    // MARK: initial setup
    private func setupTableView() {
        diningHallsTableView.delegate = self
        diningHallsTableView.dataSource = self
        let tableViewCellNib = UINib(nibName: "DiningHallTableViewCell", bundle: nil)
        diningHallsTableView.register(tableViewCellNib, forCellReuseIdentifier: DiningHallTableViewCell.cellID)
    }
    
    // MARK: tableview methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiningHallTableViewCell.cellID) as? DiningHallTableViewCell else { return UITableViewCell() }
        cell.diningHall = campus.diningHalls[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        diningHallsTableView.reloadData()
        refreshControl.endRefreshing()
    }
}
