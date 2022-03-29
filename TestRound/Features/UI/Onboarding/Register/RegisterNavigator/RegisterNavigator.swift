//
//  RegisterNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol RegisterNavigatorProtocol {
    func navigateToLogin()
}


class RegisterNavigator: RegisterNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }

    func navigateToLogin() {
        // Popping view controller
        navigationController?.popViewController(animated: true)
    }
}
