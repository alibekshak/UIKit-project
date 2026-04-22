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
    
    private lazy var deleteSelectedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Selected", for: .normal)
        button.addTarget(self, action: #selector(deleteSelectedTapped), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
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
        navigationItem.rightBarButtonItem = editButtonItem
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadStoredInfo()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        tableView.allowsMultipleSelectionDuringEditing = true
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
        
        view.addSubview(deleteSelectedButton)
        
        NSLayoutConstraint.activate([
            deleteSelectedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteSelectedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteSelectedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteSelectedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func showDeleteButton() {
        deleteSelectedButton.isHidden = false
    }

    private func hideDeleteButton() {
        deleteSelectedButton.isHidden = true
    }
    
    private func updateDeleteButtonState() {
        let hasSelection = !(tableView.indexPathsForSelectedRows?.isEmpty ?? true)
        deleteSelectedButton.isEnabled = hasSelection
        deleteSelectedButton.alpha = hasSelection ? 1 : 0.5
    }
    
    @objc private func deleteSelectedTapped() {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        
        let itemsToDelete = selectedIndexPaths.map { storedInfo[$0.row] }
        
        output?.deleteFavorites(itemsToDelete)
        
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: false)
        }
        
        setEditing(false, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        
        if editing {
            showDeleteButton()
        } else {
            hideDeleteButton()
        }
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
        if tableView.isEditing {
            updateDeleteButtonState()
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = storedInfo[indexPath.row]
        output?.tapToDetailInfoView(infoData: data)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            updateDeleteButtonState()
        }
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
