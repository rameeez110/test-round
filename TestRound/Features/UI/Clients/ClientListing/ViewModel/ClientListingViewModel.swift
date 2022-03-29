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
}

final class ClientListingViewModel: ClientListingViewModelProtocol {

    weak var delegate: ClientListingViewModelDelegate?
    private let navigator: ClientListingNavigatorProtocol

    init(navigator: ClientListingNavigatorProtocol, delegate: ClientListingViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }
}
