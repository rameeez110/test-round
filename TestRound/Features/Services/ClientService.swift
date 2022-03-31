//
//  ClientService.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

protocol ClientServiceDelegate: class {
    func didFetchClients(clients: [Client])
    func didFailWithError(clients: [Client], error: Error)
    func cantFetchClient()
}

protocol ClientServiceProtocol {
    var delegate: ClientServiceDelegate? { get set }
    func getClients()
}

final class ClientService: ClientServiceProtocol {

    weak var delegate: ClientServiceDelegate?
    var clientResponse: ClientResponseModel?
    private let clientRepository: ClientsRepositoryProtocol

    init(clientRepository: ClientsRepositoryProtocol) {
        self.clientRepository = clientRepository
    }

    func getClients() {
        (canFetchClient()) ? fetchClients(page: (clientResponse?.page ?? 0) + 1) : cantFetchClient()
    }

    private func canFetchClient() -> Bool {
        guard let clientResponse = clientResponse, (clientResponse.page != nil), (clientResponse.totalPages != nil) else { return true }
        return (clientResponse.page! == clientResponse.totalPages!) ? false : true
    }

    private func fetchClients(page: Int) {
        let requestModel = ClientRequestModel(page: page)
        clientRepository.getClients(parameters: requestModel)
    }

    private func cantFetchClient() {
        delegate?.cantFetchClient()
    }
}

extension ClientService: ClientsRepositoryDelegate {

    // MARK:- ClientRepositoryDelegate
    func didFetchClient(clients : ClientResponseModel) {
        clientResponse = clients
        delegate?.didFetchClients(clients: clients.clients ?? [])
    }
    func didFailWithError(clients :[Client], error: Error){
        delegate?.didFailWithError(clients: clients, error: error)
    }

}
