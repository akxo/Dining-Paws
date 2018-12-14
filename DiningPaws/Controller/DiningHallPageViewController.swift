//
//  DiningHallPageViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/13/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DiningHallPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var campus: Campus = loadCampus()
    lazy var days: [UIViewController] = initializeDays()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupPageView()
    }
    
    // MARK: initial ui setup
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Dining Halls"
        self.navigationController?.navigationBar.barTintColor = UConn.primaryColor
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for food"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupPageView() {
        view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        guard let firstViewController = days.first as? DayViewController else { return }
        firstViewController.campus = campus
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: initial data setup
    private func loadCampus() -> Campus {
        guard let campusData = UserDefaults.standard.data(forKey: "campusData") else { return Campus() }
        do {
            guard let campus = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(campusData) as? Campus else { return Campus() }
            campus.cleanUp()
            return campus
        } catch let error {
            print("error: \(error.localizedDescription)")
            return Campus()
        }
    }
    
    private func initializeDays() -> [DayViewController] {
        let today = Date()
        var days = [DayViewController(date: today)]
        for numDays in 1..<7 {
            guard let nextDate = Calendar.current.date(byAdding: .day, value: numDays, to: today) else { continue }
            days += [DayViewController(date: nextDate)]
        }
        return days
    }
    
    // MARK: page view methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = days.index(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }
        return days[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = days.index(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard days.count > nextIndex else { return nil }
        return days[nextIndex]
    }
}
