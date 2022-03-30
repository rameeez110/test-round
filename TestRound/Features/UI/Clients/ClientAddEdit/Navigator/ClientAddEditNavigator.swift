//
//  ClientAddEditNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol ClientAddEditNavigatorProtocol {
    func navigateToBack()
}

class ClientAddEditNavigator: ClientAddEditNavigatorProtocol {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }
    func navigateToBack() {
        // Popping view controller
        navigationController?.popViewController(animated: true)
    }
}
