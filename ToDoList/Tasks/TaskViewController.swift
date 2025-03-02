//
//  MainViewController.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

struct Task {
    var title: String
    var description: String
    var date: String
    var isCompleted: Bool
}

final class TaskViewController: UIViewController {
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.textColor = .customWhite
        return searchController
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(.addTask, for: .normal)
        button.tintColor = .accent
        return button
    }()
    
    let bottomTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .customWhite
        label.textAlignment = .center
        return label
    }()
    
    private var tasks: [Task] = []
    private var filteredTasks: [Task] = []
    private var isSearchActive: Bool { return !searchController.searchBar.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupUI()
        setupConstraints()
        fetchData()
        addNotifications()
    }
}

private extension TaskViewController {
    func setupUI() {
        searchController.searchResultsUpdater = self
        view.addSubviews(tableView, editButton, bottomTitle)
        view.backgroundColor = .background
        tableView.delegate = self
        tableView.dataSource = self
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    func setupNavbar(){
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomTitle.snp.top).offset(-20)
        }
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(68)
            make.height.equalTo(28)
        }
        bottomTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15.5)
        }
    }
     
    func fetchData() {
        
        APIClient.shared.getMockData {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let toDoItems):
                self.tasks = toDoItems.map {
                    Task(
                        title: $0.todo,
                        description: "Example description",
                        date: Date().formatDate(),
                        isCompleted: $0.completed
                    )
                }
                DispatchQueue.main.async {
                    self.bottomTitle.text = "\(self.tasks.count) задач"
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func addNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleEditTask(_:)), name: .editTask, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleShareTask(_:)), name: .shareTask, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeleteTask(_:)), name: .deleteTask, object: nil)
    }
    
    @objc func handleEditTask(_ notification: Notification) {
        guard let indexPath = getIndex(notification) else { return }
        
        let task = isSearchActive ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        let taskDetailVC = TaskDetailViewController(task: task)
        navigationController?.pushViewController(taskDetailVC, animated: true)
    }

    @objc func handleShareTask(_ notification: Notification) {
        guard let indexPath = getIndex(notification) else { return }
        
        let task = isSearchActive ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        
        let activityVC = UIActivityViewController(activityItems: [task.title, task.description], applicationActivities: nil)
        present(activityVC, animated: true)
    }

    @objc func handleDeleteTask(_ notification: Notification) {
        
        guard let indexPath = getIndex(notification) else { return }
        
        if isSearchActive {
            let originalIndex = tasks.firstIndex { $0.title == filteredTasks[indexPath.row].title }!
            tasks.remove(at: originalIndex)
            filteredTasks.remove(at: indexPath.row)
        } else {
            tasks.remove(at: indexPath.row)
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func getIndex(_ notification: Notification) -> IndexPath? {
        guard let cell = notification.object as? TaskCell,
              let indexPath = tableView.indexPath(for: cell) else { return nil }
        return indexPath
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bottomTitle.text = "\(self.tasks.count) задач"
        return isSearchActive ? filteredTasks.count : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueCell(for: indexPath)
        let task = isSearchActive ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        cell.configure(title: task.title, description: task.description, date: task.date, isCompleted: task.isCompleted)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        if isSearchActive {
            let originalIndex = tasks.firstIndex { $0.title == filteredTasks[index].title }!
            tasks[originalIndex].isCompleted.toggle()
            filteredTasks[index].isCompleted.toggle()
        } else {
            tasks[index].isCompleted.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc private func editButtonTapped() {
        let taskDetailVC = TaskDetailViewController()
        taskDetailVC.createdTask = {[weak self] task in
            guard let self, let task else { return }
            self.tasks.insert(task, at: 0)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(taskDetailVC, animated: true)
    }
}

extension TaskViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!.lowercased()
        filteredTasks = tasks.filter { $0.title.lowercased().contains(searchText) }
        tableView.reloadData()
    }
}
