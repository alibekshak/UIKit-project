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
        static let phone = "savedPhone"
        static let email = "savedEmail"
    }
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Username Management
    
    func saveUsername(_ username: String) {
        userDefaults.set(username, forKey: Keys.username)
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: Keys.username)
    }
    
    func hasUsername() -> Bool {
        return userDefaults.string(forKey: Keys.username) != nil
    }
    
    func removeUsername() {
        userDefaults.removeObject(forKey: Keys.username)
    }
        
    // MARK: - Phone

    func savePhone(_ phone: String) {
        userDefaults.set(phone, forKey: Keys.phone)
    }

    func getPhone() -> String? {
        userDefaults.string(forKey: Keys.phone)
    }

    func hasPhone() -> Bool {
        userDefaults.string(forKey: Keys.phone) != nil
    }

    func removePhone() {
        userDefaults.removeObject(forKey: Keys.phone)
    }

    // MARK: - Email

    func saveEmail(_ email: String) {
        userDefaults.set(email, forKey: Keys.email)
    }

    func getEmail() -> String? {
        userDefaults.string(forKey: Keys.email)
    }

    func hasEmail() -> Bool {
        userDefaults.string(forKey: Keys.email) != nil
    }

    func removeEmail() {
        userDefaults.removeObject(forKey: Keys.email)
    }
}
