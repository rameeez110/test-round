//
//  LoginNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol LoginNavigatorProtocol {
    func navigateToRegister()
}


class LoginNavigator: LoginNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }

    func navigateToRegister() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let registerVC: RegisterViewController = storyboard.instantiateViewController()
        //View Model create & setup
        if let nc = self.navigationController {
            let navigator = RegisterNavigator(navigationController: nc)
            let viewModel = RegisterViewModel(navigator: navigator)
            registerVC.viewModel = viewModel
            viewModel.delegate = registerVC
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}
