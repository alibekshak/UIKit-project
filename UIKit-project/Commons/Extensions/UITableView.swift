//
//  UITableView.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 19.11.2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell else {
            fatalError("register(cellClass: \(Cell.self) has not been implemented")
        }
        
        return cell
    }
    
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: "\(cellClass)")
    }
}
