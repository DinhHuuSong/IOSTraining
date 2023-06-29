//
//  LoginViewController.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ẩn activityIndicator và errorMessage khi ban đầu
            activityIndicator.stopAnimating()
            errorMessage.isHidden = true
        
        // Do any additional setup after loading the view.
        self.viewModel = UserViewModel(self, userRepository: UserRepository())
    
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Kiểm tra và hiển thị thông báo lỗi nếu có
        if let errorMessage = validateInput() {
            showError(errorMessage)
            return
        }
        
        // Gọi hàm login
        login()
    }
    
    func validateInput() -> String? {
        if let username = userName.text {
            if username.isEmpty {
                return "Please enter username"
            } else if username.count < 4 {
                return "Username must be at least 4 characters"
            }
        } else {
            return "Please enter username"
        }
        
        if let password = passWord.text {
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
    
    func login() {
        // Hiển thị activity indicator
        activityIndicator.startAnimating()
        
        // Kiểm tra đăng nhập sau 3 giây
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Lấy giá trị username và password
            guard let username = self.userName.text, let password = self.passWord.text else {
                self.showError("Login failed")
                self.activityIndicator.stopAnimating()
                return
            }
            
            // Kiểm tra đăng nhập
            self.viewModel?.login(username: username, password: password)
            
            // Dừng activity indicator
            self.activityIndicator.stopAnimating()
        }
    }



    
    func showError(_ message: String) {
        // Hiển thị thông báo lỗi
        errorMessage.isHidden = false
        errorMessage.textColor = .red
        errorMessage.text = message
    }

}
// MARK: - ViewModelDelegate
extension LoginViewController : ViewModelDelegate{
    func willLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.startAnimating()
           
        })
    }
    
    func didLoadData() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            // Hiển thị thông báo thành công
            self.errorMessage.isHidden = false
            self.errorMessage.textColor = .green
            self.errorMessage.text = "Login successful"
        })
    }
    
    func didLoadDataFailedWith(_ error: Error?) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.errorMessage.isHidden = false
                self.errorMessage.text = error.localizedDescription
            } else {
                self.errorMessage.isHidden = false
                self.errorMessage.text = "Incorrect Username or password !"
                self.errorMessage.textColor = .red
            }
        })
    }
}
