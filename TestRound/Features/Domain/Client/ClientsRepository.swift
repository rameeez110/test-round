//
//  ClientsRepository.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol ClientsRepositoryDelegate: class {
    func didFetchClient(clients : ClientResponseModel)
    func didFailWithError(clients :[Client], error: Error)
}

protocol ClientsRepositoryProtocol {
    var delegate: ClientsRepositoryDelegate? { get set }
    func getClients(parameters: ClientRequestModel)
}

final class ClientsRepository: ClientsRepositoryProtocol {
    weak var delegate: ClientsRepositoryDelegate?
    private let remoteClientDataSource: ClientsRemoteDataStoreProtocol

    init(remoteClientDataSource: ClientsRemoteDataStoreProtocol, delegate: ClientsRepositoryDelegate? = nil) {
        self.remoteClientDataSource = remoteClientDataSource
        self.delegate = delegate
    }

    func getClients(parameters: ClientRequestModel) {
        remoteClientDataSource.getClients(parameters: parameters)
    }

}

extension ClientsRepository: ClientsDataDataStoreDelegate {

    // MARK:- MoviesRemoteDataStoreDelegate
    func didFetchClients(clients : ClientResponseModel){
        delegate?.didFetchClient(clients: clients)
    }

    func didFailWithError(error: Error){
    }
}
