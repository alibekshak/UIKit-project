//
//  DetailInfoViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 21.11.2025.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    var output: DetailInfoOutput?
    
    private let item: TextInfoDataModel
    
    // MARK: - UI
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Genre: \(item.genre ?? "")"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Author: \(item.author ?? "")"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = item.content
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            contentLabel,
            authorLabel,
            genreLabel
        ])
        stack.setCustomSpacing(4, after: authorLabel)
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var addToFavorite: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(didAddToFavorite)
        )
        button.tintColor = .red
        
        return button
    }()
    
    // MARK: - Init
    
    init(item: TextInfoDataModel) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSettings()
        setup()
        makeConstraints()
        output?.onViewDidLoad(item: item)
    }
    
    func configureInitialFavoriteState(isFavorite: Bool) {
        setFavoriteButtonState(isFavorite: isFavorite)
    }
    
    // MARK: - Actions
    
    @objc private func didAddToFavorite() {
        output?.addToFavorite(data: item)
    }
    
    // MARK: - Private methods
    
    private func pageSettings() {
        view.backgroundColor = .systemBackground
        title = item.title
        navigationItem.rightBarButtonItem = addToFavorite
    }
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func makeConstraints() {
        let layoutGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
            ])
    }
}

// MARK: - DetailInfoInput

extension DetailInfoViewController: DetailInfoInput {
    
    func setFavoriteButtonEnabled(_ enabled: Bool) {
        addToFavorite.isEnabled = enabled
    }
    
    func setFavoriteButtonState(isFavorite: Bool) {
        
        addToFavorite.image = UIImage(systemName: isFavorite ? "checkmark" : "plus")
        addToFavorite.tintColor = isFavorite ? .systemGray : .systemRed
    }
}
