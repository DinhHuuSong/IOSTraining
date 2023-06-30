//
//  LoginViewModel.swift
//  SongDH
//
//  Created by Dinh Song on 2023/06/29.
//
// LoginViewModel.swift

import Foundation

// ViewModel for handling login related tasks.
class LoginViewModel {
    weak var delegate: LoginModelDelegate?
    
    // MARK: - Initialization
    // Initialize ViewModel with optional delegate.
    init(_ delegate: LoginModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Login Related Methods
    
    // Function: login(username:password:)
    // This function checks the provided username and password. If they are both "admin", it triggers a successful login process. Otherwise, it reports a login failure.
    // - Parameter username: The username inputted by the user. This is validated against a predefined correct username.
    // - Parameter password: The password inputted by the user. This is validated against a predefined correct password.
    // Note: In this mock implementation, the correct username and password are both "admin".
    func login(username: String, password: String) {
        delegate?.willLogin()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if username == "admin" && password == "admin" {
                self.delegate?.didLogin()
            } else {
                let error = ValidationError(errorType: .incorrectCredentials, errorMessage: ErrorType.incorrectCredentials.errorMessage)
                self.delegate?.didLoginFailedWith(error)
            }
        }
    }
    
    
    // Function: buttonAction(username:password:)
    // This function is called when the login button is tapped. It checks if the username and password are not nil, and if so, validates them. If the validation passes, it attempts to log in. If the validation fails, it handles the validation error.
    // - Parameter username: The optional string representing the username entered by the user.
    // - Parameter password: The optional string representing the password entered by the user.
    // Note: If either the username or password are nil, the function will print "nil" and return early.
    func buttonAction(username: String?, password: String?) {
        if let unwrappedUsername = username, let unwrappedPassword = password {
            if let validationError = validate(username: unwrappedUsername, password: unwrappedPassword) {
                handle(validationError)
            } else {
                login(username: unwrappedUsername, password: unwrappedPassword)
            }
        } else {
            print("nil")
            return
        }
    }
    
    
    // Function: validate(username:password:)
    // This function validates the given username and password.
    // - Parameter username: The username to be validated. It should be a non-empty string with at least 4 characters.
    // - Parameter password: The password to be validated. It should be a non-empty string with at least 4 characters.
    // - Returns: If any of the username or password is invalid, it returns a `ValidationError` instance representing the first encountered error.
    //            If both username and password are valid, it returns nil.
    func validate(username: String, password: String) -> ValidationError? {
        if let usernameError = validateUsername(username) {
            return ValidationError(errorType: usernameError, errorMessage: usernameError.errorMessage)
        }
        
        if let passwordError = validatePassword(password) {
            return ValidationError(errorType: passwordError, errorMessage: passwordError.errorMessage)
        }
        
        return nil
    }
    
    // Function: validateUsername(_:)
    // This function validates the given username.
    // - Parameter username: The username to be validated. It should be a non-empty string with at least 4 characters.
    // - Returns: If the username is empty, it returns `ErrorType.usernameEmpty`. If the username is less than 4 characters, it returns `ErrorType.usernameTooShort`. If the username is valid, it returns nil.
    func validateUsername(_ username: String) -> ErrorType? {
        if username.isEmpty {
            return .usernameEmpty
        } else if username.count < 4 {
            return .usernameTooShort
        }
        
        return nil
    }
    
    // Function: validatePassword(_:)
    // This function validates the given password.
    // - Parameter password: The password to be validated. It should be a non-empty string with at least 4 characters.
    // - Returns: If the password is empty, it returns `ErrorType.passwordEmpty`. If the password is less than 4 characters, it returns `ErrorType.passwordTooShort`. If the password is valid, it returns nil.
    func validatePassword(_ password: String) -> ErrorType? {
        if password.isEmpty {
            return .passwordEmpty
        } else if password.count < 4 {
            return .passwordTooShort
        }
        
        return nil
    }
    
    // Function: handle(_:)
    // This function handles the given validation error by passing it to the delegate's `didLoginFailedWith(_:)` method.
    // - Parameter validationError: The `ValidationError` instance representing the validation error to be handled.
    func handle(_ validationError: ValidationError) {
        self.delegate?.didLoginFailedWith(validationError)
    }
}

// Enum for holding different types of validation errors
enum ErrorType {
    case usernameEmpty
    case passwordEmpty
    case usernameTooShort
    case passwordTooShort
    case usernameNil
    case passwordNil
    case incorrectCredentials
    var errorMessage: String {
        switch self {
        case .usernameEmpty:
            return "Please enter username"
        case .passwordEmpty:
            return "Please enter password"
        case .usernameTooShort:
            return "Username must be at least 4 characters"
        case .passwordTooShort:
            return "Password must be at least 4 characters"
        case .usernameNil :
            return "User name can't nil"
        case .passwordNil :
            return "Password can't nil"
        case .incorrectCredentials :
            return "Incorrect Username or password !"
        }
        
    }
}

// Struct for representing a validation error with an error type and message
struct ValidationError: Error {
    var errorType: ErrorType
    var errorMessage: String
    
    init(errorType: ErrorType, errorMessage: String) {
        self.errorType = errorType
        self.errorMessage = errorMessage
    }
}
