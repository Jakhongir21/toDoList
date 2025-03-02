//
//  MockDataResponse.swift
//  ToDoList
//
//  Created by Jakhongir on 24/02/25.
//

import Foundation

struct MockDataResponse: Codable {
    let result: [TaskModel]
    
    enum CodingKeys: String, CodingKey {
        case result = "todos"
    }
}

struct TaskModel: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
