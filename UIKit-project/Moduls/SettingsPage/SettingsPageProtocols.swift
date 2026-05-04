//
//  SettingsPageProtocols.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.01.2026.
//

import Foundation

protocol SettingsPageOutput: AnyObject {
    func navigateToFavoritePage()
    func navigateToProfilePage()
    func logout()
}
