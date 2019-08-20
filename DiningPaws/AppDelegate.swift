//
//  AppDelegate.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/6/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var locationManager = CLLocationManager()
    lazy var campus: Campus = loadCampus()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let homeDiningHall = User.currentUser.homeDiningHall, let dayVC = dayViewController(for: homeDiningHall) {
            
            let navigationController = UINavigationController(rootViewController: dayVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else if User.currentUser.locationBasedLoadIsEnabled, let diningHall = closestDiningHall(), let dayVC = dayViewController(for: diningHall) {
            
            let navigationController = UINavigationController(rootViewController: dayVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            let navigationController = UINavigationController(rootViewController: CampusPageViewController())
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let campusViewController = navigationController.viewControllers.first(where: { $0 is CampusPageViewController }) as? CampusPageViewController,
            let firstDayViewController = campusViewController.days.first as? DiningHallsViewController,
            !firstDayViewController.date.isEqual(to: Date()) else { return }
        
        campusViewController.campus = loadCampus()
        campusViewController.days = campusViewController.initializeDays()
        campusViewController.setupPageView()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
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
    
    // MARK: location methods
    private func closestDiningHall() -> String? {
        guard CLLocationManager.locationServicesEnabled(), checkLocationAuthorization(), let location = locationManager.location else { return nil }
        return closestDiningHall(to: location)
    }
    
    // MARK: location methods
    private func checkLocationAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        default:
            return false
        }
    }
    
    private func closestDiningHall(to location: CLLocation) -> String {
        var closestDiningHall: String?
        var shortestDistance: Double?
        for diningHall in campus.diningHalls {
            let distance = location.distance(from: diningHall.location).magnitude
            if shortestDistance == nil || distance < shortestDistance! {
                shortestDistance = distance
                closestDiningHall = diningHall.name
            }
        }
        return closestDiningHall ?? "Buckley"
    }
    
    // MARK: load specific day
    private func dayViewController(for diningHall: String) -> DayViewController? {
        guard let diningHall = campus.diningHalls.first(where: { $0.name == diningHall }), let day = getDay(for: diningHall) else { return nil }
        let mealName = UConn.status(for: diningHall, on: Date())
        let initialMealIndex = day.index(for: mealName)
        return DayViewController(diningHallName: diningHall.name, day: day, initialMealIndex: initialMealIndex ?? 0)
    }
    
    private func getDay(for diningHall: DiningHall) -> Day? {
        let today = Date()
        if let day = diningHall.day(for: today) { return day }
        if let day = MenuClient.shared.day(for: today, at: diningHall) {
            diningHall.days[today.id] = day
            return day
        }
        return nil
    }
}

