//
//  HomePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.11.2025.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private var navigationTitle: UILabel = {
        let label = UILabel()
        label.text = "Home page"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(cellClass: HomePageCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavigationTitle()
    }
    
    // MARK: private methods
    private func setupNavigationTitle() {
        navigationItem.titleView = navigationTitle
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomePageCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
}
