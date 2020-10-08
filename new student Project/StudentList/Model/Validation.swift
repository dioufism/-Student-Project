//
//  Validation.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import Foundation
extension String {
    
    var isValidName: Bool {
        let regex =  "[A-Za-z]{3,26}" //pattern that we wanna recognize
        let test =  NSPredicate(format:"SELF MATCHES %@", regex) // not sure what is happening here
        return test.evaluate(with: self)
    }
    
    var isEmailValid: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,65}"
        let test = NSPredicate (format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    var isPhoneNumberValid: Bool {
        let regex = "^\\d{3}-\\d{3}-\\d{4}$"
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)
        return test.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,65}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
