//
//  Address.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

struct Address: Decodable {
    var city: String?
    var country: String?
    var street: String?
    var zip: String?
    
    init(street: String,city: String,zip:String,country: String) {
        self.city = city
        self.country = country
        self.street = street
        self.zip = zip
    }
    init() {
        
    }
    private enum CodingKeys: String, CodingKey {
        case city
        case country
        case zip
        case street
    }
}
