//
//  User.swift
//  TestRound
//
//  Created by Rameez Hasan on 31/03/2022.
//

import UIKit

class User: Decodable {
    var userId: Int?
    var email: String?
    var password: String?
    
    init(userId: Int,email: String,password:String) {
        self.userId = userId
        self.email = email
        self.password = password
    }
    init() {
        
    }
    private enum CodingKeys: String, CodingKey {
        case userId
        case email
        case password
    }
}
