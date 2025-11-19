//
//  HomePageCell.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 19.11.2025.
//

import UIKit

final class HomePageCell: UITableViewCell {
    
    // MARK: - UI
    private var title: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = .systemFont(ofSize: 14, weight: .semibold)
        title.numberOfLines = 1
        return title
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
