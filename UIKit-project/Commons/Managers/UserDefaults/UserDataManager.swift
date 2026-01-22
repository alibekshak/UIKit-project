//
//  UserDataManager.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 18.01.2026.
//

import Foundation

final class UserDataManager: UserDataManagerProtocol {
    
    private enum Keys {
        static let username = "savedUsername"
    }
    
    private let userDefault = UserDefaults.standard
    
    // MARK: - Username Management
    
    func saveUsername(_ username: String) {
        userDefault.set(username, forKey: Keys.username)
    }
    
    func getUsername() -> String? {
        return userDefault.string(forKey: Keys.username)
    }
    
    func hasUsername() -> Bool {
        return userDefault.string(forKey: Keys.username) != nil
    }
    
    func removeUsername() {
        userDefault.removeObject(forKey: Keys.username)
    }
}
