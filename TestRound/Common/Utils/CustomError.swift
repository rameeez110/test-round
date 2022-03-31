//
//  CustomError.swift
//  TestRound
//
//  Created by Rameez Hasan on 30/03/2022.
//

import Foundation

class CustomError {
    var errorCode : Int!
    var errorString : String!
    
    init(errorCode:Int? = nil,errorString: String) {
        self.errorCode = errorCode
        self.errorString = errorString
    }
    
    init()
    {
    
    }
}
