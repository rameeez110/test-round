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
    // Using this method to get section title for client add edit screen 
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
    
    // Validation Methods
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Using regex to validate passowrd pattern
    func validatePassword(text: String) -> Bool {
        let passwordRegex = "^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\\d]){1,})(?=(.*[\\W]){1,})(?!.*\\s).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: text)
    }
}
