//
//  RegisterViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol RegisterViewModelDelegate: class {
    func alert(with title: String, message: String)
    func validationError(error: String)
}

// Protocol for view model will use it for wiring
protocol RegisterViewModelProtocol {

    var delegate: RegisterViewModelDelegate? { get set }

    func didTapLogin()
    func didTapRegister(email: String,password: String,confirmPassword: String)
}

final class RegisterViewModel: RegisterViewModelProtocol {

    weak var delegate: RegisterViewModelDelegate?

    private let navigator: RegisterNavigatorProtocol

    init(navigator: RegisterNavigatorProtocol, delegate: RegisterViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }

    func didTapLogin() {
        navigator.navigateToLogin()
    }

    func didTapRegister(email: String,password: String,confirmPassword: String) {
        let (status,string) = self.validateFields(email: email, password: password, confirmPassword: confirmPassword)
        if status {
            navigator.navigateToClientsVC()
        } else {
            self.delegate?.validationError(error: string)
        }
    }
    func validateFields(email: String,password: String,confirmPassword: String) -> (Bool,String) {
        var string = ""
        if email.isEmpty {
            string = "Please enter email address"
            return (false,string)
        }
        
        if !CommonClass.sharedInstance.isValidEmail(email) {
            string = "Please enter valid email address"
            return (false,string)
        }
        
        if password.isEmpty {
            string = "Please enter password"
            return (false,string)
        }
        
        if !CommonClass.sharedInstance.validatePassword(text: password) {
            string = "Password must contain at least one number,one special character,one lowercase and one uppercase letters"
            return (false,string)
        }
        if confirmPassword.isEmpty {
            string = "Please enter confirm password"
            return (false,string)
        }
        
        if confirmPassword != password {
            string = "Password and confirm password must be matched"
            return (false,string)
        }
        return (true,"")
    }
}
