//
//  Address.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

struct Address: Codable {
    var city = String()
    var country = String()
    var street = String()
    var zip = String()
    var id = Int()
    
    init(street: String,city: String,zip:String,country: String) {
        self.city = city
        self.country = country
        self.street = street
        self.zip = zip
    }
    init() {
        
    }
    
    var dictionary: [String: Any] {
      return [
        "city": self.city,
        "street": self.street,
        "country": self.country,
        "zip": self.zip,
      ]
    }
}
