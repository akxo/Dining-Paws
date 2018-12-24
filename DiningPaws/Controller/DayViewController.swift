//
//  DayViewController.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/15/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mealSelectionBar: UICollectionView!
    @IBOutlet weak var mealCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var horizontalBarView: UIView!
    @IBOutlet weak var horizontalBarValueX: NSLayoutConstraint!
    @IBOutlet weak var horizontalBarWidth: NSLayoutConstraint!
    
    let mealSelectionBarCellID = "mealSelectionBarCellID"
    
    let diningHallName: String
    let day: Day
    var initialMealIndex: Int?
    
    init(diningHallName: String, day: Day, initialMealIndex: Int) {
        self.diningHallName = diningHallName
        self.day = day
        self.initialMealIndex = initialMealIndex
        super.init(nibName: "DayViewController", bundle: Bundle(for: DiningHallsViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        setupSubViews()
        setupMealSelectionBar()
        setupMealCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        guard let index = initialMealIndex,
            let _ = mealSelectionBar.cellForItem(at: IndexPath(item: index, section: 0)),
            day.meals.count > 0 else { return }
        initialMealIndex = nil
        selectMeal(at: index)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = self.diningHallName
        self.navigationController?.navigationBar.barTintColor = UConn.primaryColor
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for food"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupSubViews() {
        let hasMeals = day.meals.count > 0
        dateLabel.text = day.date.description
        mealSelectionBar.isHidden = !hasMeals
        horizontalBarView.isHidden = !hasMeals
        guard hasMeals else { return }
        horizontalBarWidth.constant = (UIScreen.main.bounds.size.width - 10) /  CGFloat(day.meals.count)
    }
    
    private func setupMealSelectionBar() {
        mealSelectionBar.delegate = self
        mealSelectionBar.dataSource = self
        let mealSelectionBarCellNib = UINib(nibName: "MealSelectionBarCell", bundle: nil)
        mealSelectionBar.register(mealSelectionBarCellNib, forCellWithReuseIdentifier: MealSelectionBarCell.cellID)
        mealSelectionBar.frame.size = CGSize(width: UIScreen.main.bounds.width - 10, height: 40)
    }
    
    private func setupMealCollectionView() {
        mealCollectionView.delegate = self
        mealCollectionView.dataSource = self
        let mealOptionsCellNib = UINib(nibName: "MealOptionsCell", bundle: nil)
        mealCollectionView.register(mealOptionsCellNib, forCellWithReuseIdentifier: MealOptionsCell.cellID)
        mealCollectionView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
    }
    
    private func selectMeal(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        mealSelectionBar.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        mealCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mealSelectionBar {
            return CGSize(width: collectionView.frame.size.width / CGFloat(day.meals.count), height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let index = initialMealIndex else { return }
        if collectionView == mealSelectionBar {
            if indexPath.item == day.meals.count - 1 {
                selectMeal(at: index)
                initialMealIndex = nil
                usleep(120000)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mealSelectionBar {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealSelectionBarCell.cellID, for: indexPath) as? MealSelectionBarCell else { return UICollectionViewCell() }
            cell.mealNameLabel.text = day.meals[indexPath.row].name
            cell.mealNameLabel.textColor = UConn.secondaryColor
            cell.favoriteImageView.isHidden = !day.meals[indexPath.item].hasFavorite()
            return cell
        } else if collectionView == mealCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealOptionsCell.cellID, for: indexPath) as? MealOptionsCell else { return UICollectionViewCell() }
            cell.meal = day.meals[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == mealSelectionBar else { return }
        selectMeal(at: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        horizontalBarValueX.constant = (horizontalBarWidth.constant * (scrollView.contentOffset.x / mealCollectionView.frame.size.width)) + 5
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / mealCollectionView.frame.size.width)
        let indexPath = IndexPath(item: index, section: 0)
        mealSelectionBar.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
