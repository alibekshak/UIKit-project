//
//  UserDataManagerProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 22.01.2026.
//

import Foundation

protocol UserDataManagerProtocol: AnyObject {
    // Username
    func saveUsername(_ username: String)
    func getUsername() -> String?
    func hasUsername() -> Bool
    func removeUsername()
    
    // Phone
    func savePhone(_ phone: String)
    func getPhone() -> String?
    func hasPhone() -> Bool
    func removePhone()

    // Email
    func saveEmail(_ email: String)
    func getEmail() -> String?
    func hasEmail() -> Bool
    func removeEmail()
}
