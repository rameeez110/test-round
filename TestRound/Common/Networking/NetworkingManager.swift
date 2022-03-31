//
//  NetworkingManager.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Alamofire

typealias CompletionHandlerType = (Result) -> Void

struct DefaultAPIRequest: APIRequest {
    let request: DataRequest
    func cancel() {
        request.cancel()
    }
}

class NetworkManager: Networking {
    
    public init() { }
    
    func get<R: Encodable>(request: RequestBuilder<R>, completion: @escaping CompletionHandlerType) -> APIRequest {
        
        return execute(url: request.path.url,
                       method: .get,
                       parameters: request.parameters,
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: request.headers,
                       completion: completion)
        
    }
    
    func post<R: Encodable>(request: RequestBuilder<R>, completion: @escaping CompletionHandlerType) -> APIRequest {
        
        return execute(url: request.path.url,
                       method: .post,
                       parameters: request.parameters,
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: request.headers,
                       completion: completion)
    }
    
    func put<R: Encodable>(request: RequestBuilder<R>, completion: @escaping CompletionHandlerType) -> APIRequest {
        
        return execute(url: request.path.url,
                       method: .put,
                       parameters: request.parameters,
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: request.headers,
                       completion: completion)
    }
    
    func execute<R: Encodable>(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: R?,
        encoder: ParameterEncoder,
        headers: [String: String]?,
        completion:@escaping CompletionHandlerType) -> APIRequest {
            
            let headers: HTTPHeaders? = headers.map({ HTTPHeaders($0) })
            
            let dataRequest = AF.request(url,
                                         method: method,
                                         parameters: parameters,
                                         encoder: encoder,
                                         headers: headers)
//                .validate()
//                .responseDecodable { (response: DataResponse<T>) in
//                    completion(APIResponse(result: response.result))
//                }
                .validate(contentType: ["application/json"])
                .responseJSON {(response) in
                    switch response.result
                    {
                    case .success(_):
                        print("Response of API: \(url), \nPayload: \(response)")
                        completion(Result.Success(response))
                    case .failure(let error):
                        print("Failure of API: \(url), \nPayload: \(error)")
                    }
                }
            
            return DefaultAPIRequest(request: dataRequest)
        }
}

enum Result {
    case Success(AFDataResponse<Any>?)
    case FailureDueToService(CustomError)
    case Failure(CustomError)
}
