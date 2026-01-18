//
//  UserDataManager.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 18.01.2026.
//

import Foundation

final class UserDataManager {
    
    private enum Keys {
        static let username = "savedUsername"
    }
    
    private static let userDefault = UserDefaults.standard
    
    // MARK: - Username Management
    
    static func saveUsername(_ username: String) {
        userDefault.set(username, forKey: Keys.username)
    }
    
    static func getUsername() -> String? {
        return userDefault.string(forKey: Keys.username)
    }
    
    static func hasUsername() -> Bool {
        return userDefault.string(forKey: Keys.username) != nil
    }
    
    static func removeUsername() {
        userDefault.removeObject(forKey: Keys.username)
    }
}
