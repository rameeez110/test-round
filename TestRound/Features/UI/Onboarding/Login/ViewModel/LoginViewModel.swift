//
//  LoginViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol LoginViewModelDelegate: class {
    func alert(with title: String, message: String)
    func validationError(error: String)
}

// Protocol for view model will use it for wiring
protocol LoginViewModelProtocol {

    var delegate: LoginViewModelDelegate? { get set }

    func didTapLogin(email: String,password: String)
    func didTapRegister()
}

final class LoginViewModel: LoginViewModelProtocol {

    weak var delegate: LoginViewModelDelegate?

    private let navigator: LoginNavigatorProtocol

    init(navigator: LoginNavigatorProtocol, delegate: LoginViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }

    func didTapLogin(email: String,password: String) {
        let (status,string) = self.validateFields(email: email, password: password)
        if status {
            navigator.navigateToClientsVC()
        } else {
            self.delegate?.validationError(error: string)
        }
    }

    func didTapRegister() {
        navigator.navigateToRegister()
    }
    func validateFields(email: String,password: String) -> (Bool,String) {
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
        return (true,"")
    }
}
