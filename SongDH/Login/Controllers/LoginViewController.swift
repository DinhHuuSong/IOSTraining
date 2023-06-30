//
//  LoginViewController.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//

import UIKit

// Controller for managing login screen UI
class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide activityIndicator and errorMessage at the start
                activityIndicator.stopAnimating()
                errorMessage.isHidden = true
                
                // Do any additional setup after loading the view.
                self.viewModel = LoginViewModel(self)
        
    }
    
    // This function is triggered when the login button is tapped.
    // It calls the `buttonAction(username:password:)` method from the ViewModel
    // passing the current text values of the username and password fields.
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewModel?.buttonAction(username: userName.text, password: passWord.text)
    }


 

}
// MARK: - ViewModelDelegate
extension LoginViewController : LoginModelDelegate{
    // Function called when before login action.
    func willLogin() {
        // Schedule a block of code for execution on the main queue. This is important because
        // all UI updates should be performed on the main thread.
        DispatchQueue.main.async {
            // Start the activity indicator to show that the login process has begun.
            self.activityIndicator.startAnimating()
        }
    }

    
    // Function called when login successful.
    func didLogin() {
        // Schedule UI updates on the main queue for smooth user experience
        DispatchQueue.main.async {
            // Stop and hide the activity indicator on successful login
            self.activityIndicator.stopAnimating()
            
            // Display a success message to the user via the 'errorMessage' label
            self.errorMessage.isHidden = false
            self.errorMessage.textColor = .green
            self.errorMessage.text = "Login successful"
        }
    }


    
    // Function called when login fails.
    // Displays an error message depending on the type of error received.
    func didLoginFailedWith(_ error: Error?) {
        // Always update UI elements on the main queue.
        DispatchQueue.main.async {
            // Stop the activity indicator as the login process has finished.
            self.activityIndicator.stopAnimating()

            // If the error is of type ValidationError
            guard let validationError = error as? ValidationError else {
                // If the error is not a ValidationError, no further action is taken.
                // You might want to handle this case differently depending on your requirements.
                return
            }

            // If we get this far, it means we have a ValidationError.
            // The error message is not hidden anymore.
            self.errorMessage.isHidden = false
            // Set the error message to the error message from the ValidationError.
            self.errorMessage.text = validationError.errorMessage
            // Set the text color to red to highlight the error message.
            self.errorMessage.textColor = .red
        }
    }
}





