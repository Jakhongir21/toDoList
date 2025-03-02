//
//  MainCell.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import UIKit

final class TaskCell: BaseTableCell {
    
    private lazy var bottomView = UIView()
    
    private lazy var titleLabel = UILabel(
        font: .systemFont(ofSize: 16, weight: .medium),
        color: .customWhite,
        lines: 0,
        alignment: .left
    )
    
    private lazy var descriptionLabel = UILabel(
        font: .systemFont(ofSize: 12, weight: .regular),
        color: .customWhite,
        lines: 0,
        alignment: .left
    )
    
    private lazy var dateLabel = UILabel(
        font: .systemFont(ofSize: 12, weight: .light),
        color: .customWhite,
        lines: 0
    )

    private let checkmark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .grayColor
        return imageView
    }()
    
    private lazy var contentVStackView = UIStackView(
        axis: .vertical,
        distribution: .fill,
        alignment: .fill,
        layoutMargins: nil,
        spacing: 6
    )
    
    func setup() {
        bottomView.backgroundColor = .grayColor
        backgroundColor = .black
        selectionStyle = .none
        contentView.addSubviews(checkmark, contentVStackView, bottomView)
        
        contentVStackView.addArrangedSubviews(titleLabel, descriptionLabel, dateLabel)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        addInteraction(interaction)
    }
    
    func setupConstraints(){
        checkmark.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
        
        contentVStackView.snp.makeConstraints({
            $0.left.equalTo(checkmark.snp.right).offset(8)
            $0.right.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(12)
        })
        
        bottomView.snp.makeConstraints({
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkmark.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
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

extension TaskCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { _ in
                NotificationCenter.default.post(name: .editTask, object: self)
            }
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                NotificationCenter.default.post(name: .shareTask, object: self)
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                NotificationCenter.default.post(name: .deleteTask, object: self)
            }
            
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
}
