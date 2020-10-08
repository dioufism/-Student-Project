//
//  StudentModel.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import Foundation
import UIKit

class Student {
    var studentImage: UIImage
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    
    init() {
        studentImage = #imageLiteral(resourceName: "icons8-user_groups")
        firstName = ""
        lastName = ""
        phoneNumber = ""
        email = ""
    }
        
    init(image: UIImage, firstName: String, lastName: String, email: String, phoneNumber:String) { //designated init
        self.phoneNumber = phoneNumber
        self.studentImage = image
        self.firstName = firstName
        self.lastName = lastName
        self.email =  email
    }
    
    
    
        
    
}
