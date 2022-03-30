//
//  CommonClass.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit

class CommonClass {
    // Using single ton object
    static var sharedInstance = CommonClass()
}

extension CommonClass {
    func getSectionHeader(sectionType: ClientSections) -> String {
        var string = ""
        switch sectionType {
        case .PersonalId:
            string = "Personal Id"
        case .Email:
            string = "Email Address"
        case .PhoneNumber:
            string = "Mobile Number"
        case .Gender:
            string = "Gender"
        case .Address:
            string = "Address"
        case .Account:
            string = "Account"
        }
        return string
    }
}
