//
//  ClientAddEditViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol ClientAddEditViewModelDelegate: class {
    func alert(with title: String, message: String)
}

// Protocol for view model will use it for wiring
protocol ClientAddEditViewModelProtocol {
    var delegate: ClientAddEditViewModelDelegate? { get set }
    
    func didTapBack()
}

final class ClientAddEditViewModel: ClientAddEditViewModelProtocol {
    weak var delegate: ClientAddEditViewModelDelegate?
    private let navigator: ClientAddEditNavigatorProtocol

    init(navigator: ClientAddEditNavigatorProtocol, delegate: ClientAddEditViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }
    
    func didTapBack() {
        navigator.navigateToBack()
    }
}
