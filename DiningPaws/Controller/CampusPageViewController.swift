//
//  CampusPageViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/13/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class CampusPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UISearchResultsUpdating {
    
    lazy var campus: Campus = loadCampus()
    lazy var days: [UIViewController] = initializeDays()
    var currentIndex = 0
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        setupNavigationButtons()
        setupPageView()
    }
    
    // MARK: initial ui setup
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Dining Halls"
        self.navigationController?.navigationBar.barTintColor = UConn.primaryColor
    }
    
    private func setupSearchBar() {
        let searchResults = SearchTableViewController()
        searchResults.campus = campus
        let searchController = UISearchController(searchResultsController: searchResults)
        searchResults.resultSelected = { result in
            self.goToSearchResult(result)
            searchController.dismiss(animated: true, completion: {
                searchController.resignFirstResponder()
                searchController.searchBar.text = nil
            })
        }
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for food"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .white
    }
    
    private func setupNavigationButtons() {
        let favoritesButton = UIBarButtonItem(image: UIImage(named: "filledStar"), style: .plain, target: self, action: #selector(favoritesButtonTapped))
        favoritesButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = favoritesButton
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        settingsButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = settingsButton
    }
    
    private func setupPageView() {
        self.dataSource = self
        self.delegate = self
        guard let firstViewController = days.first as? DiningHallsViewController else { return }
        firstViewController.campus = campus
        setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
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
    
    private func initializeDays() -> [DiningHallsViewController] {
        let today = Date()
        var days = [DiningHallsViewController]()
        for numDay in 0..<7 {
            guard let nextDate = Calendar.current.date(byAdding: .day, value: numDay, to: today) else { continue }
            let diningHallsViewController = DiningHallsViewController(date: nextDate, index: numDay)
            diningHallsViewController.swipe = { offset in
                self.currentIndex += offset
                let direction: NavigationDirection = offset > 0 ? .forward : .reverse
                let nextViewController = self.days[self.currentIndex] as! DiningHallsViewController
                nextViewController.campus = self.campus
                self.setViewControllers([nextViewController], direction: direction, animated: true, completion: nil)
            }
            days.append(diningHallsViewController)
        }
        return days
    }
    
    // MARK: page view methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = days.index(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else { return nil }
        let viewController = days[previousIndex] as? DiningHallsViewController
        viewController?.campus = campus
        self.currentIndex = previousIndex
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = days.index(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        guard days.count > nextIndex else { return nil }
        let viewController = days[nextIndex] as? DiningHallsViewController
        viewController?.campus = campus
        self.currentIndex = nextIndex
        return days[nextIndex]
    }
    
    // MARK: actions
    @objc private func favoritesButtonTapped() {
        let favoritesTableViewController = FavoritesTableViewController()
        self.navigationController?.pushViewController(favoritesTableViewController, animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    // MARK: search methods
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text?.lowercased()
        guard let searchResultsController = searchController.searchResultsController as? SearchTableViewController else { return }
        searchResultsController.updateSearchResults(for: text)
    }
    
    private func goToSearchResult(_ result: SearchResult) {
        let diningHall = self.campus.diningHalls[result.diningHallIndex]
        let day = diningHall.days[result.dayIndex]
        let dayViewController = DayViewController(diningHallName: diningHall.name, day: day, initialMealIndex: result.mealIndex)
        self.navigationController?.pushViewController(dayViewController, animated: true)
    }
}
