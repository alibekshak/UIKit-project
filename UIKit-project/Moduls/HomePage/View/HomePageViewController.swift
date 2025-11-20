//
//  HomePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.11.2025.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var infoData: [TextInfoData] = [
        TextInfoData(
            title: "Title some ",
            author: "Author A",
            genre: "some",
            content: "Text"
        ),
        TextInfoData(
            title: "Title some 2",
            author: "Author AADs",
            genre: "some some",
            content: "Text TEXT"
    )]
    
    // MARK: - UI
    
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
        tableView.backgroundColor = .systemBackground
        tableView.register(cellClass: HomePageCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationTitle()
        setup()
    }
    
    // MARK: Private methods
    private func setupNavigationTitle() {
        navigationItem.titleView = navigationTitle
    }
    
    private func setup() {
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomePageCell = tableView.dequeueReusableCell(for: indexPath)
        let data = infoData[indexPath.row]
        cell.configure(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
