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
    
    init(diningHallName: String, day: Day) {
        self.diningHallName = diningHallName
        self.day = day
        super.init(nibName: "DayViewController", bundle: Bundle(for: DiningHallsViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubViews()
        
        
        mealSelectionBar.delegate = self
        mealSelectionBar.dataSource = self
        let mealSelectionBarCellNib = UINib(nibName: "MealSelectionBarCell", bundle: nil)
        mealSelectionBar.register(mealSelectionBarCellNib, forCellWithReuseIdentifier: MealSelectionBarCell.cellID)
        
        let indexPath = IndexPath(item: 0, section: 0)
        mealSelectionBar.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        guard let cell = mealSelectionBar.cellForItem(at: indexPath) else { return }
        cell.isSelected = true
        
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = self.diningHallName
        self.navigationController?.navigationBar.barTintColor = UConn.primaryColor
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
        dateLabel.text = day.date.description
        mealSelectionBar.isHidden = day.meals.isEmpty
        horizontalBarWidth.constant = mealSelectionBar.frame.size.width /  CGFloat(day.meals.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / CGFloat(day.meals.count), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealSelectionBarCell.cellID, for: indexPath) as? MealSelectionBarCell else { return UICollectionViewCell() }
        cell.mealNameLabel.text = day.meals[indexPath.row].name
        cell.mealNameLabel.textColor = UConn.secondaryColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.isSelected = true
        horizontalBarValueX.constant = (horizontalBarWidth.constant * CGFloat(indexPath.item)) + 5
    }
}
