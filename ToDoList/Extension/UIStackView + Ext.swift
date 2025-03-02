//
//  UIStackView + Ext.swift
//  ToDoList
//
//  Created by Jakhongir on 02/03/25.
//

import UIKit

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        layoutMargins: UIEdgeInsets? = nil,
        spacing: CGFloat = 0
    ) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        if let layoutMargins = layoutMargins {
            self.layoutMargins = layoutMargins
            isLayoutMarginsRelativeArrangement = true
        }
    }
    
    func build(axis: NSLayoutConstraint.Axis = .horizontal,
               distribution: UIStackView.Distribution = .fill,
               alignment: UIStackView.Alignment = .fill,
               layoutMargins: UIEdgeInsets? = nil,
               spacing: CGFloat = 0){
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        if let layoutMargins = layoutMargins {
            self.layoutMargins = layoutMargins
            isLayoutMarginsRelativeArrangement = true
        }
    }

    
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...){
        views.forEach({
            addArrangedSubview($0)
        })
    }
}
