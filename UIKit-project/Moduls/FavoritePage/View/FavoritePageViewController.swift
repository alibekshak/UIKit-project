//
//  FavoritePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 12.12.2025.
//

import UIKit

class FavoritePageViewController: BaseViewController {
    
    var output: FavoritePageOutput?
    
    // MARK: - Private properties
    
    private var storedInfo: [TextInfoData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output?.loadStoredInfo()
    }
}

// MARK: - FavoritePageInput

extension FavoritePageViewController: FavoritePageInput {
    func showStoredInfo(content: [TextInfoData]) {
        self.storedInfo = content
    }
}
