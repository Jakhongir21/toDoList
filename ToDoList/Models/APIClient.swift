//
//  APIClient.swift
//  ToDoList
//
//  Created by Jakhongir on 02/03/25.
//

import Foundation

class APIClient {

    enum APIError: Error {
        case didThrowError
        case invalidData
        case decodingError
    }
    
    static let shared = APIClient()
    
    private init(){}
    
    func getMockData(completion: @escaping ((Result<[TaskModel], Error>) -> ())){
        let urlString = "https://dummyjson.com/todos"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard error == nil else {
                completion(.failure(APIError.didThrowError))
                return
            }
            guard let data else {
                completion(.failure(APIError.invalidData))
                return
            }
            do {
                let model = try JSONDecoder().decode(MockDataResponse.self, from: data)
                completion(.success(model.result))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }
        task.resume()
    }
    
}
