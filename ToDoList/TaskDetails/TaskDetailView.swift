//
//  TaskDetailView.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

class TaskDetailView: BaseView {
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 25, weight: .bold)
        textField.textColor = .customWhite
        textField.tintColor = .accent
        textField.placeholder = "Title for your task"
        return textField
    }()
    
    private lazy var dateLabel = UILabel(
        text: Date().formatDate(),
        font: .systemFont(ofSize: 12, weight: .regular),
        color: .customWhite.withAlphaComponent(0.5),
        lines: 0
    )
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .customWhite
        textView.tintColor = .accent
        textView.text = "Write Something..."
        return textView
    }()
    
    
    private lazy var contentVStackView = UIStackView(
        axis: .vertical,
        distribution: .fill,
        alignment: .fill,
        layoutMargins: nil,
        spacing: 8
    )
    
    func setup() {
        addSubview(contentVStackView)
        backgroundColor = .black
        contentVStackView.addArrangedSubviews(titleTextField, dateLabel, descriptionTextView)
    }
    
    func setupConstraints() {
        
        contentVStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalToSuperview().offset(20)
        }
    }
    
    func configure(title: String, date: String, description: String) {
        titleTextField.text = title
        dateLabel.text = date
        descriptionTextView.text = description
    }
}
