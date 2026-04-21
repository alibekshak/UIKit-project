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
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(cellClass: HomePageCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No favorites"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadStoredInfo()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        tableView.backgroundView = emptyStateLabel
        emptyStateLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - FavoritePageInput

extension FavoritePageViewController: FavoritePageInput {
    func showStoredInfo(content: [TextInfoData]) {
        self.storedInfo = content
        tableView.reloadData()
        
        emptyStateLabel.isHidden = !content.isEmpty
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoritePageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storedInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomePageCell = tableView.dequeueReusableCell(for: indexPath)
        let data = storedInfo[indexPath.row]
        cell.configure(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = storedInfo[indexPath.row]
        output?.tapToDetailInfoView(infoData: data)
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        
        let item = storedInfo[indexPath.row]
        output?.deleteFavorite(item)
    }
}
