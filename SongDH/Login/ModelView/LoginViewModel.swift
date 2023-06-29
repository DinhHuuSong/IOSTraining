//
//  LoginViewModel.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import Foundation

class LoginViewModel {
    weak var delegate: LoginModelDelegate?
    
    // MARK: - Init
    init(_ delegate: LoginModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Logic
    func validateInput(username: String?, password: String?) -> String? {
        if let username = username {
            if username.isEmpty {
                return "Please enter username"
            } else if username.count < 4 {
                return "Username must be at least 4 characters"
            }
        } else {
            return "Please enter username"
        }
        
        if let password = password {
            if password.isEmpty {
                return "Please enter password"
            } else if password.count < 4 {
                return "Password must be at least 4 characters"
            }
        } else {
            return "Please enter password"
        }
        
        return nil
    }
    
    // MARK: - CHECK
    func Login(username: String, password: String) {
        // Gọi hàm delegate để thông báo bắt đầu quá trình đăng nhập
        self.delegate?.willLogin()
        // Kiểm tra đăng nhập sau 3 giây
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Thực hiện kiểm tra đăng nhập (kiểm tra tên người dùng và mật khẩu)
            if username == "admin" && password == "admin" {
                // Đăng nhập thành công
                self.delegate?.didLogin()
            } else {
                // Đăng nhập thất bại
                let error = NSError(domain: "LoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Incorrect Username or Password"])
                self.delegate?.didLoginFailedWith(error)
            }
        }
    }
}
