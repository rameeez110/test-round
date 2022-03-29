//
//  RegisterViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol RegisterViewModelDelegate: class {
    func alert(with title: String, message: String)
}

protocol RegisterViewModelProtocol {

    var delegate: RegisterViewModelDelegate? { get set }

    func didTapLogin()
    func didTapRegister()
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

    func didTapRegister() {
    }
}
