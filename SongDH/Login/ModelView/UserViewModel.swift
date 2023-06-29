//
//  LoginViewModel.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

class UserViewModel {
    weak var delegate: ViewModelDelegate?
    
    private var users: [User] = []
    private var userRepository: UserRepository
    
    // MARK: - Init
    
    init(_ delegate: ViewModelDelegate? = nil, userRepository: UserRepository) {
        self.delegate = delegate
        self.userRepository = userRepository
    }
    
    // MARK: - Model property
    
    func getUserNumber() -> Int {
        return self.users.count
    }
    
    func getUserNameAt(_ indexPath: IndexPath) -> String {
        return self.users[indexPath.row].name
    }
    
    func getUserEmailAt(_ indexPath: IndexPath) -> String {
        return self.users[indexPath.row].email
    }
    
    // MARK: - API
    
    func login(username: String, password: String) {
        // Gọi hàm delegate để thông báo bắt đầu quá trình đăng nhập
        delegate?.willLoadData()
        
        // Thực hiện kiểm tra đăng nhập (kiểm tra tên người dùng và mật khẩu)
        if username == "admin" && password == "admin" {
            // Đăng nhập thành công
            delegate?.didLoadData()
        } else {
            // Đăng nhập thất bại
            let error = NSError(domain: "LoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Incorrect Username or Password"])
            delegate?.didLoadDataFailedWith(error)
        }
    }

}
