//
//  DetailInfoViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 21.11.2025.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    private let item: TextInfoData
    
    init(item: TextInfoData) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = item.title
    }
    
}
