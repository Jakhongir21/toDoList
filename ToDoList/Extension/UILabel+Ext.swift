//
//  UILabel+Ext.swift
//  ToDoList
//
//  Created by Jakhongir on 02/03/25.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, font: UIFont, color: UIColor, lines: Int, alignment: NSTextAlignment = .left){
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
    
    func buildLabel(text: String? = nil, font: UIFont, color: UIColor, lines: Int, alignment: NSTextAlignment = .left){
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
