//
//  HomePageViewController.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 17.11.2025.
//

import UIKit

class HomePageViewController: BaseViewController {
    
    var output: HomePageOutput?
    
    // MARK: - Private properties
    
    private var infoData: [TextInfoData] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadInfo()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = infoData[indexPath.row]
        
        let vc = DetailInfoViewController(item: data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - HomePageInput

extension HomePageViewController: HomePageInput {
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            mainTableView.isHidden = true
            showLoading()
        } else {
            mainTableView.isHidden = false
            hideLoading()
        }
    }
    
    func showError(_ message: String) {
        showAlert(title: message)
    }
    
    func showInfo(content: [TextInfoData]) {
        self.infoData = content
        self.mainTableView.reloadData()
    }
}
