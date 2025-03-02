//
//  MainViewController.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

class TaskViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Задачи"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(hex: "F4F4F4")
        label.textAlignment = .center
        return label
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.barStyle = .black
        search.searchTextField.backgroundColor = .clear
        search.searchTextField.textColor = UIColor(hex: "F4F4F4")
        return search
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(hex: "040404")
        table.separatorStyle = .none
        table.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier) // Register custom cell
        return table
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setImage(.addTask, for: .normal)
        button.tintColor = UIColor(hex: "#FED702")
        return button
    }()
    
    let bottomTitle: UILabel = {
        let label = UILabel()
        label.text = "7 Задач"
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(hex: "F4F4F4")
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    struct Task {
        var title: String
        var description: String
        var date: String
        var isCompleted: Bool
    }
    
    
    private var tasks: [Task] = []
//    private var tasks: [Task] = [
//        Task(title: "Почитать книгу", description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.", date: "09/10/24", isCompleted: false),
//        Task(title: "Уборка в квартире", description: "Провести генеральную уборку в квартире", date: "02/10/24", isCompleted: false),
//        Task(title: "Заняться спортом", description: "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку и растяжку!", date: "02/10/24", isCompleted: false),
//        Task(title: "Работа над проектом", description: "Выделить время для работы над проектом на работе. Сфокусироваться на выполнении важных задач.", date: "09/10/24", isCompleted: false),
//        Task(title: "Вечерний отдых", description: "Найти время для расслабления перед сном: посмотреть фильм или послушать музыку", date: "02/10/24", isCompleted: false),
//        Task(title: "Зарядка утром", description: "Сделать утреннюю зарядку перед началом дня.", date: "02/10/24", isCompleted: false)
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "040404")
        tableView.delegate = self
        tableView.dataSource = self
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        view.addSubviews(titleLabel, searchBar, tableView, editButton, bottomTitle)
        setupConstraints()
        APIClient.shared.getMockData { result in
            switch result {
            case .success(let toDoItems):
                self.tasks = toDoItems.map({
                    return Task(
                        title: $0.todo,
                        description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
                        date: "09/10/24",
                        isCompleted: $0.completed
                    )
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(36)
            
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
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
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15.5)
        }
        
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        
        cell.configure(title: task.title, description: task.description, date: task.date, isCompleted: task.isCompleted)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tasks[indexPath.row].isCompleted.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc private func editButtonTapped() {
        let taskDetailVC = TaskDetailViewController()
        navigationController?.pushViewController(taskDetailVC, animated: true)
    }
    
}
