//
//  Client.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

struct Client {
    var firstName = String()
    var lastName = String()
    var sex = Gender.Male
    var accounts = [String]()
    var personalId = String()
    var phoneNumber = String()
    var email = String()
    var address = Address()
    var avatarId = String()
    
    var dictionary: [String: Any] {
      return [
        "profilePicture": self.avatarId,
        "firstName": self.firstName,
        "lastName": self.lastName,
        "address": self.address.dictionary,
        "accounts": self.getAccounts(),
        "email": self.email,
        "personalId": self.personalId,
        "phoneNumber": self.phoneNumber,
        "sex": self.sex.rawValue,
      ]
    }
    func getAccounts() -> [String] {
        var array = [String]()
        for each in accounts {
            array.append(each)
        }
        return array
    }
}
