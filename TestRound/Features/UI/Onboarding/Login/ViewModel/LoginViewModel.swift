//
//  LoginViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol LoginViewModelDelegate: class {
    func alert(with title: String, message: String)
}

protocol LoginViewModelProtocol {

    var delegate: LoginViewModelDelegate? { get set }

    func didTapLogin()
    func didTapRegister()
}

final class LoginViewModel: LoginViewModelProtocol {

    weak var delegate: LoginViewModelDelegate?

    private let navigator: LoginNavigatorProtocol

    init(navigator: LoginNavigatorProtocol, delegate: LoginViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }

    func didTapLogin() {
        
    }

    func didTapRegister() {
        navigator.navigateToRegister()
    }
}
