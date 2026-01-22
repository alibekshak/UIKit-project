//
//  UserDataManagerProtocol.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 22.01.2026.
//

import Foundation

protocol UserDataManagerProtocol: AnyObject {
    func saveUsername(_ username: String)
    func getUsername() -> String?
    func hasUsername() -> Bool
    func removeUsername()
}
