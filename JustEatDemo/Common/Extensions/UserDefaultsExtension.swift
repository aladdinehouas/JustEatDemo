//
//  UserDefaultsExtension.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 4/4/2022.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let sortOptionKey = "sortOptionKey"
    }
    
    class var sortOptionKey: SortOption? {
        get {
            let rawValue = UserDefaults.standard.object(forKey: Keys.sortOptionKey) as? String
            return SortOption(rawValue: rawValue ?? "")
        }
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: Keys.sortOptionKey)
        }
    }
    
}
