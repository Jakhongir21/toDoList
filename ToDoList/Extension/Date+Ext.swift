//
//  Date+Ext.swift
//  ToDoList
//
//  Created by Jakhongir on 03/03/25.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}
