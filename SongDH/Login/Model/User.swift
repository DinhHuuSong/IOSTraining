//
//  User.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

class User: Codable {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
