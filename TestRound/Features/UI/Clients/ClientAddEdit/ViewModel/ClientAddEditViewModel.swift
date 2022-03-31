//
//  ClientAddEditViewModel.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import UIKit
import PhoneNumberKit

protocol ClientAddEditViewModelDelegate: class {
    func alert(with title: String, message: String)
    func validationError(error: String)
}

// Protocol for view model will use it for wiring
protocol ClientAddEditViewModelProtocol {
    var delegate: ClientAddEditViewModelDelegate? { get set }
    
    func didTapBack()
    func didTapDone()
    func mapUIDataSource()
}

final class ClientAddEditViewModel: ClientAddEditViewModelProtocol {
    weak var delegate: ClientAddEditViewModelDelegate?
    private let navigator: ClientAddEditNavigatorProtocol
    var client: Client?

    init(navigator: ClientAddEditNavigatorProtocol, delegate: ClientAddEditViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
    }
    
    func didTapBack() {
        navigator.navigateToBack()
    }
    func didTapDone() {
        let (status,string) = self.validateFields()
        if status {
            // Need to call api here to update or create
        } else {
            self.delegate?.validationError(error: string)
        }
    }
    func mapUIDataSource() {
        
    }
    func validateFields() -> (Bool,String) {
        var string = ""
        let phoneNumberKit = PhoneNumberKit()
        if var model = self.client {
            if model.email?.isEmpty ?? true{
                string = "Please enter email address"
                return (false,string)
            }
            
            if !CommonClass.sharedInstance.isValidEmail(model.email ?? "") {
                string = "Please enter valid email address"
                return (false,string)
            }
            
            if model.firstName?.isEmpty ?? true {
                string = "Please enter first name"
                return (false,string)
            }
            
            if model.firstName?.count ?? 0 < 60 {
                string = "First name must be less than 60 characters"
                return (false,string)
            }
            
            if model.lastName?.count ?? 0 < 60 {
                string = "Last name must be less than 60 characters"
                return (false,string)
            }
            do {
                let phoneNumber = try phoneNumberKit.parse(model.phoneNumber ?? "")
                model.phoneNumber = "\(phoneNumber.countryCode)\(phoneNumber.numberString)"
            }
            catch {
                string = "Please enter valid phone number with country code"
                return (false,string)
            }
            
            if model.personalId?.isEmpty ?? true {
                string = "Please enter personal id"
                return (false,string)
            }
            if model.sex != 0 || model.sex != 1{
                string = "Please select gender"
                return (false,string)
            }
            if model.accounts?.count == 0 {
                string = "You must have at least 1 account"
                return (false,string)
            }
        }
        return (true,"")
    }
}
