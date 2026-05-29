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
        let label = UILabel.make(
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .gray,
            numberOfLines: 1
        )
        
        return label
    }()
    
    private var author: UILabel = {
        let label = UILabel.make(
            font: .systemFont(ofSize: 14, weight: .regular),
            color: .darkGray
        )
        
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        contentView.addSubview(title)
        contentView.addSubview(author)
        
        NSLayoutConstraint.activate([
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
        author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
        author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        author.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    public func configure(_ data: TextInfoDataModel) {
        title.text = data.title
        author.text = data.author
    }
}
