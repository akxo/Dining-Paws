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
        setupRefreshView()
        dateLabel.text = date.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let count = campus.diningHalls.reduce(0, { (count, diningHall) in
            count + (diningHall.days.contains(where: { $0.date.isEqual(to: self.date) }) ? 1 : 0)
        })
        guard count < 8 else {
            refreshControl.endRefreshing()
            return
        }
        diningHallsTableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl.frame.size.height)
        refreshControl.beginRefreshing()
        DispatchQueue.global(qos: .background).async {
            self.campus.addDay(for: self.date, completion: {
                DispatchQueue.main.async {
                    self.diningHallsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            })
        }
    }
    
    // MARK: initial setup
    private func setupTableView() {
        diningHallsTableView.delegate = self
        diningHallsTableView.dataSource = self
        let tableViewCellNib = UINib(nibName: "DiningHallTableViewCell", bundle: nil)
        diningHallsTableView.register(tableViewCellNib, forCellReuseIdentifier: DiningHallTableViewCell.cellID)
    }
    
    private func setupRefreshView() {
        refreshControl = UIRefreshControl()
        diningHallsTableView.addSubview(refreshControl)
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
