//
//  ClientListingNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit


protocol ClientListingNavigatorProtocol {
    func navigateToClienAddUpdate()
}

class ClientListingNavigator: ClientListingNavigatorProtocol {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }
    func navigateToClienAddUpdate() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .client)
        let addEditVC: ClientAddEditViewController = storyboard.instantiateViewController()
        //View Model create & setup
        if let nc = self.navigationController {
            let navigator = ClientAddEditNavigator.init(navigationController: nc)
            let viewModel = ClientAddEditViewModel.init(navigator: navigator)
            viewModel.delegate = addEditVC
            addEditVC.viewModel = viewModel
            navigationController?.pushViewController(addEditVC, animated: true)
        }
    }
}
