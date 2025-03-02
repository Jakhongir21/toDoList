//
//  TaskDetailCell.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

class TaskDetailCell: UITableViewCell {
        
        static let identifier = "TaskDetailCell"
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Заняться спортом"
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = UIColor(hex: "#F4F4F4")
            return label
        }()
        
        private let dateLabel: UILabel = {
            let label = UILabel()
            label.text = "02/10/24"
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            label.textColor = UIColor(hex: "#F4F4F4")
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике."
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = UIColor(hex: "#F4F4F4")
            label.numberOfLines = 0
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .black
            selectionStyle = .none
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.addSubview(titleLabel)
            contentView.addSubview(dateLabel)
            contentView.addSubview(descriptionLabel)
            
            titleLabel.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(20)
            }
            
            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.equalToSuperview().offset(20)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(16)
                make.leading.trailing.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(-15)
            }
        }

    }
