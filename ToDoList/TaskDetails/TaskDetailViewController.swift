//
//  TaskDetailViewController.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    lazy var mainView = TaskDetailView()
    
    private var task: Task?
    
    init(task: Task? = nil) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        navigationItem.largeTitleDisplayMode = .never
        if let task {
            mainView.configure(title: task.title, date: task.date, description: task.description)
        }
    }
}
