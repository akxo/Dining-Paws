//
//  DiningHallsViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/10/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diningHallsTableView: UITableView!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    var swipe: ((Int) -> Void)?
    var refreshControl: UIRefreshControl!

    var campus: Campus!
    var date: Date
    var index: Int
    var loadAttempt: Int = 0
    
    private var hasDay: Bool {
        let count = campus.diningHalls.reduce(0) { $0 + ($1.days[date] != nil ? 1 : 0) }
        guard count == 8 else { return false }
        return true
    }
    
    init(date: Date, index: Int) {
        self.date = date
        self.index = index
        super.init(nibName: "DiningHallsViewController", bundle: Bundle(for: DiningHallsViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: view life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshView()
        setupDateHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diningHallsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard !hasDay else { return }
        diningHallsTableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl.frame.size.height)
        refreshControl.beginRefreshing()
        loadDay()
    }
    
    // MARK: initial setup
    private func setupDateHeader() {
        dateLabel.text = date.description
        leftArrowButton.isHidden = index == 0 ? true : false
        rightArrowButton.isHidden = index == 6 ? true : false
    }
    
    private func setupTableView() {
        diningHallsTableView.delegate = self
        diningHallsTableView.dataSource = self
        diningHallsTableView.rowHeight = 85
        let tableViewCellNib = UINib(nibName: "DiningHallTableViewCell", bundle: nil)
        diningHallsTableView.register(tableViewCellNib, forCellReuseIdentifier: DiningHallTableViewCell.cellID)
    }
    
    private func setupRefreshView() {
        refreshControl = UIRefreshControl()
        diningHallsTableView.addSubview(refreshControl)
    }
    
    private func loadDay() {
        DispatchQueue.global(qos: .background).async {
            self.campus.addDay(for: self.date, completion: {
                DispatchQueue.main.async {
                    self.loadAttempt += 1
                    self.diningHallsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            })
        }
    }
    
    private func setPagingIsEnabled(to isEnabled: Bool) {
        guard let parent = self.parent as? CampusPageViewController else { return }
        parent.view.isUserInteractionEnabled = isEnabled
    }
    
    private func setUserInteraction(to isEnabled: Bool) {
        self.leftArrowButton.isUserInteractionEnabled = isEnabled
        self.rightArrowButton.isUserInteractionEnabled = isEnabled
        self.diningHallsTableView.isUserInteractionEnabled = isEnabled
        self.navigationController?.navigationBar.isUserInteractionEnabled = isEnabled
        self.navigationItem.searchController?.searchBar.isUserInteractionEnabled = isEnabled
    }
    
    // MARK: tableview methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !hasDay && loadAttempt > 0 ? 1 : 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiningHallTableViewCell.cellID) as? DiningHallTableViewCell else { return UITableViewCell() }
        guard hasDay || loadAttempt == 0 else {
            cell.networkErrorLabel.isHidden = false
            return cell
        }
        cell.date = self.date
        cell.diningHall = campus.diningHalls[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diningHall = campus.diningHalls[indexPath.row]
        guard let day = diningHall.days[date] else { return }
        let mealName = UConn.status(for: diningHall, on: Date())
        let initialMealIndex = day.index(for: mealName)
        let dayViewController = DayViewController(diningHallName: diningHall.name, day: day, initialMealIndex: initialMealIndex ?? 0)
        self.navigationController?.pushViewController(dayViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard refreshControl.isRefreshing else { return }
        guard !hasDay else {
            diningHallsTableView.reloadData()
            refreshControl.endRefreshing()
            return
        }
        loadDay()
    }
    
    @IBAction func leftArrowTapped(_ sender: UIButton) {
        guard index >= 1 else { return }
        swipe?(-1)
    }
    
    @IBAction func rightArrowTapped(_ sender: UIButton) {
        guard index < 6 else { return }
        swipe?(1)
    }
}
