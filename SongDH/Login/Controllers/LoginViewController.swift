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
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ẩn activityIndicator và errorMessage khi ban đầu
        activityIndicator.stopAnimating()
        errorMessage.isHidden = true
        
        // Do any additional setup after loading the view.
        self.viewModel = LoginViewModel(self)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Kiểm tra tên người dùng và mật khẩu
        guard let username = userName.text, let password = passWord.text else {
            return
        }
        //Kiểm tra validation
        let validationError: String? = viewModel?.validateInput(username: username, password: password)
        
        //nếu có lỗi validation thì dừng và thông báo
        if let error = validationError {
            errorMessage.isHidden = false
            errorMessage.text = error
            return
        }
        
        // Gọi phương thức Login của viewModel để bắt đầu quá trình đăng nhập
        viewModel?.Login(username: username, password: password)
    }
    
}
// MARK: - ViewModelDelegate
extension LoginViewController : LoginModelDelegate{
    func willLogin() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.startAnimating()
        })
    }
    
    func didLogin() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.activityIndicator.stopAnimating()
            // Hiển thị thông báo thành công
            self.errorMessage.isHidden = false
            self.errorMessage.textColor = .green
            self.errorMessage.text = "Login successful"
        })
    }
    
    func didLoginFailedWith(_ error: Error?) {
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
