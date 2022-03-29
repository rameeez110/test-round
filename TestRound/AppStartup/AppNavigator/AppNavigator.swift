//
//  AppNavigator.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

struct AppNavigator {

    func installRoot(into window: UIWindow) {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let vc: ViewController = storyboard.initialViewController()
        let rootController = AppNavigationController(rootViewController: vc)
        // View Model create & setup
        let navigator = LoginNavigator(navigationController: rootController)
        let viewModel = LoginViewModel(navigator: navigator)
        
//        service.delegate = viewModel
        viewModel.delegate = vc
        vc.viewModel = viewModel
        
        window.rootViewController = rootController
    }
}
