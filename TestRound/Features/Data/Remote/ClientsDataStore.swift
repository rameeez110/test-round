//
//  ClientsDataStore.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

protocol ClientsDataDataStoreDelegate: class {
    func didFetchClients(clients : ClientResponseModel)
    func didFailWithError(error: Error)
}

protocol ClientsRemoteDataStoreProtocol {
    var delegate: ClientsDataDataStoreDelegate? { get set }
    func getClients(parameters: ClientRequestModel)
}

final class ClientsDataStore: ClientsRemoteDataStoreProtocol {

    weak var delegate: ClientsDataDataStoreDelegate?
    private let networkManager: Networking
    private let endpoint = "movie/now_playing"

    init(networkManager: Networking = NetworkManager(), delegate: ClientsDataDataStoreDelegate? = nil) {
        self.delegate = delegate
        self.networkManager = networkManager
    }

    func getClients(parameters: ClientRequestModel) {
        let path = APIPathBuilder(baseURL: Constants.API.baseURL, endPoint: endpoint)
        let request = RequestBuilder(path: path, parameters: parameters)

        networkManager.get(request: request, completion: { (response) in
            
            switch(response){
            case .Success(let json):
//                self.delegate?.didFetchClients(clients: json)
                break
            case .FailureDueToService(let error):
//                self.delegate?.didFailWithError(error: error)
                print("")
            case .Failure(_):
                print("")
//                let error2 = CustomError.init(errorCode: 250, errorString: "Failure")
//                self.delegate?.didFailWithError(error: error2)
            }
        })
    }

}
