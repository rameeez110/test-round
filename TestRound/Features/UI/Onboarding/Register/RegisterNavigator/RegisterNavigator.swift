//
//  RegisterNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol RegisterNavigatorProtocol {
    func navigateToLogin()
    func navigateToClientsVC()
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
    func navigateToClientsVC() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .client)
        let clientListingVC: ClientListingViewController = storyboard.instantiateViewController()
        //View Model create & setup
        if let nc = self.navigationController {
            let navigator = ClientListingNavigator(navigationController: nc)
            let remoteDataSource = ClientsDataStore()
            let repository = ClientsRepository.init(remoteClientDataSource: remoteDataSource)
            let service = ClientService(clientRepository: repository)
            let viewModel = ClientListingViewModel(clientService: service, navigator: navigator)
            viewModel.delegate = clientListingVC
            clientListingVC.viewModel = viewModel
            navigationController?.pushViewController(clientListingVC, animated: true)
        }
    }
}
