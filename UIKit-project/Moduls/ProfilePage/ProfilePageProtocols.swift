//
//  ProfilePageProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 24.01.2026.
//

import Foundation

protocol ProfilePageOutput: AnyObject {
    var username: String { get set }
    func saveUserName()
    func clearUserName()
}
