//
//  TaskDetailViewController.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

class TaskDetailViewController: UIViewController {
        
    
    lazy var tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = UIColor(hex: "#040404")
        table.register(TaskDetailCell.self, forCellReuseIdentifier: TaskDetailCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var backButton: UIButton = {
       let button = UIButton()
        button.setImage(.backButton, for: .normal)
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(UIColor(hex: "#FED702"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(hex: "040404")
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubviews(backButton, tableView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            backButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
                make.leading.equalToSuperview().offset(20)
            }
            
            tableView.snp.makeConstraints { make in
                make.top.equalTo(backButton.snp.bottom).offset(10)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    
        @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
    }

    extension TaskDetailViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskDetailCell.identifier, for: indexPath) as! TaskDetailCell
            return cell
        }
    }
