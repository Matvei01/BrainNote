//
//  NotesViewController.swift
//  AuthorisationApp
//
//  Created by Matvei Khlestov on 25.06.2024.
//

import UIKit

final class NotesViewController: UITableViewController {
    
    // MARK: -  Private Properties
    private var notes: [Note] = []
    
    // MARK: -  UI Elements
    private lazy var backBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            primaryAction: barButtonItemTapped
        )
        button.tag = 0
        return button
    }()
    
    private lazy var addNoteBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            systemItem: .add,
            primaryAction: barButtonItemTapped
        )
        button.tag = 1
        return button
    }()
    
    // MARK: -  Action
    private lazy var barButtonItemTapped = UIAction { [unowned self] action in
        guard let sender = action.sender as? UIBarButtonItem else { return }
        
        switch sender.tag {
        case 0:
            barButtonItemAction(notificationName: .showProfile)
        default:
            barButtonItemAction(notificationName: .showAddNotes)
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

// MARK: - Table view data source
extension NotesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteViewCell.cellId, for: indexPath)
        guard let cell = cell as? NoteViewCell else { return UITableViewCell() }
        let note = notes[indexPath.row]
        cell.configure(with: note)
        return cell
    }
}

// MARK: - Private methods
private extension NotesViewController {
    func setupTableView() {
        tableView.register(
            NoteViewCell.self,
            forCellReuseIdentifier: NoteViewCell.cellId
        )
        
        tableView.rowHeight = 110
        
        fetchNotes()
        
        setupNavigationBar()
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationBar() {
        title = "Мои заметки"
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.appBlack
        ]
        navigationController?.navigationBar.tintColor = .appRed
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = addNoteBarButtonItem
    }
    
    func barButtonItemAction(notificationName: Notification.Name) {
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    func fetchNotes() {
            LoadingNotesDataService.shared.fetchNotes { [weak self] result in
                switch result {
                case .success(let notes):
                    self?.notes = notes
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Failed to fetch notes: \(error)")
                }
            }
        }
}

