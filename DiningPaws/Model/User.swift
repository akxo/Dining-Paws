//
//  User.swift
//  DiningPaws
//
//  Created by Alexander Kerendian on 12/12/18.
//  Copyright © 2018 Aktrapp. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {

    var favorites: [String]
    var enabledFavorites: Set<String>
    var homeDiningHall: String?
    var locationBasedLoadIsEnabled: Bool
    
    static var currentUser: User = loadCurrentUser() ?? User(favorites: [], enabledFavorites: Set<String>(), homeDiningHall: nil, locationBasedLoadIsEnabled: false)
    
    // MARK: init
    init(favorites: [String], enabledFavorites: Set<String>, homeDiningHall: String?, locationBasedLoadIsEnabled: Bool) {
        self.favorites = favorites
        self.enabledFavorites = enabledFavorites
        self.homeDiningHall = homeDiningHall
        self.locationBasedLoadIsEnabled = locationBasedLoadIsEnabled
    }
    
    // MARK: persistence
    private enum Key: String {
        case favorites = "favorites"
        case enabledFavorites = "enabledFavorites"
        case homeDiningHall = "homeDiningHall"
        case locationBasedLoadIsEnabled = "locationBasedLoadIsEnabled"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(favorites, forKey: Key.favorites.rawValue)
        aCoder.encode(enabledFavorites, forKey: Key.enabledFavorites.rawValue)
        aCoder.encode(homeDiningHall, forKey: Key.homeDiningHall.rawValue)
        aCoder.encode(locationBasedLoadIsEnabled, forKey: Key.locationBasedLoadIsEnabled.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let favorites = aDecoder.decodeObject(forKey: Key.favorites.rawValue) as? [String],
            let enabledFavorites = aDecoder.decodeObject(forKey: Key.enabledFavorites.rawValue) as? Set<String> else { return nil }
        let homeDiningHall = aDecoder.decodeObject(forKey: Key.homeDiningHall.rawValue) as? String
        let locationBasedLoadIsEnabled = aDecoder.decodeBool(forKey: Key.locationBasedLoadIsEnabled.rawValue)
        self.init(favorites: favorites, enabledFavorites: enabledFavorites, homeDiningHall: homeDiningHall, locationBasedLoadIsEnabled: locationBasedLoadIsEnabled)
    }
    
    static private func loadCurrentUser() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: "userData") else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userData) as? User
        } catch let error {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: functional methods
    public func add(_ favorite: String) {
        guard !favorites.map({ $0.lowercased() }).contains(favorite.lowercased()) else { return }
        favorites.append(favorite)
        enabledFavorites.insert(favorite)
        favorites.sort()
        save()
    }
    
    public func remove(_ favorite: String) {
        guard let index = favorites.firstIndex(of: favorite) else { return }
        favorites.remove(at: index)
        enabledFavorites.remove(favorite)
        save()
    }
    
    public func changeStatus(for favorite: String) {
        if enabledFavorites.contains(favorite) {
            enabledFavorites.remove(favorite)
        } else {
            enabledFavorites.insert(favorite)
        }
        save()
    }
    
    private func save() {
        do {
            let userData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(userData, forKey: "userData")
        } catch let error {
            print("error: \(error)")
        }
    }
}
