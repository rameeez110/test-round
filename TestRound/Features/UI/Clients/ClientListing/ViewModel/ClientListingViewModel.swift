//
//  ClientListingViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol ClientListingViewModelDelegate: class {
    func alert(with title: String, message: String)
}

// Protocol for view model will use it for wiring
protocol ClientListingViewModelProtocol {
    var delegate: ClientListingViewModelDelegate? { get set }
    
    func didTapAdd()
}

final class ClientListingViewModel: ClientListingViewModelProtocol {
    weak var delegate: ClientListingViewModelDelegate?
    private let navigator: ClientListingNavigatorProtocol
    private var clients: [Client] = []
    private let clientService: ClientServiceProtocol
    
    var isLast: Bool = false {
        didSet {
            if isLast {
                clientService.getClients()
            }
        }
    }

    init(clientService: ClientServiceProtocol, navigator: ClientListingNavigatorProtocol, delegate: ClientListingViewModelDelegate? = nil) {
        self.clientService = clientService
        self.delegate = delegate
        self.navigator = navigator
    }
    
    func didTapAdd() {
        navigator.navigateToClienAddUpdate()
    }
}
