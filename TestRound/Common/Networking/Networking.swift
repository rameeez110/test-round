//
//  Networking.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

//1. Define entire app endpoints and environment
struct APIPathBuilder {
    let url: String

    init(baseURL: String , endPoint: String) {
        self.url = baseURL + endPoint
    }
}

//2. Request Builder
struct RequestBuilder<Parameter: Encodable> {
    let path: APIPathBuilder
    let parameters: Parameter
    let headers: [String: String]?

    init(path: APIPathBuilder, parameters: Parameter, headers: [String: String]? = nil){
        self.path = path
        self.parameters = parameters
        self.headers = headers
    }
}

//3. API Response
struct APIResponse<T> {
//    public let result: Result<T, Error>
}

//4. Cancelable Request
protocol APIRequest {
    func cancel()
}

//5. Perform API request using differnt restful methods
protocol Networking {
    typealias Completion<T> = (APIResponse<T>) -> Void

    @discardableResult
    func get<R: Encodable>(
        request: RequestBuilder<R>,
        completion: @escaping CompletionHandlerType) -> APIRequest

    func post<R: Encodable>(
        request: RequestBuilder<R>,
        completion: @escaping CompletionHandlerType) -> APIRequest

    func put<R: Encodable>(
        request: RequestBuilder<R>,
        completion: @escaping CompletionHandlerType) -> APIRequest
}
