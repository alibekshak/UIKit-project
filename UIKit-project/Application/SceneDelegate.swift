//
//  SceneDelegate.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 03.11.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let rootView = TabBarController()
        let navigationController = UINavigationController(rootViewController: rootView)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

