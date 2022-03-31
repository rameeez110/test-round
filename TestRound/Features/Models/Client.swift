//
//  Client.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

struct Client: Decodable {
    var firstName: String?
    var lastName: String?
//    var sex: Gender?
    var accounts: [String]?
    var personalId: String?
    var phoneNumber: String?
    var email: String?
    var address: Address?
    var avatarId: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
//        case sex
        case clients
        case accounts
        case personalId = "personal_id"
        case email
        case phoneNumber = "phone_number"
        case avatarId = "profile_photo"
        case address
    }
    init(from decoder: Decoder) throws {
        
    }
}

struct ClientResponseModel {
    let page: Int?
    let totalPages: Int?
    let clients: [Client]?
    
    init(page: Int,totalPages: Int,clients: [Client]) {
        self.page = page
        self.totalPages = totalPages
        self.clients = clients
    }
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case clients = "results"
    }
}

struct ClientRequestModel: Encodable {
    let page: Int
}
