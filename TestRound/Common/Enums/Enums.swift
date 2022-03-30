//
//  Enums.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation
import PhoneNumberKit

enum Gender: Int {
    case Male = 0,Female
}

enum ClientSections: Int {
    case PersonalId = 0,Email,PhoneNumber,Gender,Address,Account
}
