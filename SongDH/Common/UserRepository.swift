//
//  UserRepository.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

class UserRepository {
    enum Constant {
        static let URLString = "https://jsonplaceholder.typicode.com/users1"
    }
    
    func fetchUsers(completion: @escaping (_ result: Result<[User]>) -> Void) {
        if let url = URL(string: Constant.URLString) {
            NetworkClient.get(url: url, completion: { result in
                completion(result)
            })
        }
    }
}
