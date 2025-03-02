//
//  MainCell.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    private lazy var bottomView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .customWhite
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customWhite
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .customWhite
        return label
    }()
    
    private let checkmark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle") // Default unchecked
        imageView.tintColor = UIColor(hex: "4D555E")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bottomView.backgroundColor = .grayColor
        backgroundColor = .black
        selectionStyle = .none
        contentView.addSubviews(checkmark, titleLabel, descriptionLabel, dateLabel, bottomView)
        
        checkmark.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(checkmark.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(12)
        }
        
        bottomView.snp.makeConstraints({
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, description: String, date: String, isCompleted: Bool) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = date
        
        if isCompleted {
            checkmark.image = UIImage(systemName: "checkmark.circle.fill")
            checkmark.tintColor = .yellow
            titleLabel.textColor = .gray
            let attributedText = NSAttributedString(string: title, attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.gray
            ])
            titleLabel.attributedText = attributedText
        } else {
            checkmark.image = UIImage(systemName: "circle")
            checkmark.tintColor = .gray
            titleLabel.textColor = .white
            titleLabel.attributedText = NSAttributedString(string: title, attributes: [
                .foregroundColor: UIColor.white
            ])
        }
    }
}
