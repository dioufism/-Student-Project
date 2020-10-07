//
//  StudentListTableViewCell.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import UIKit

class StudentListTableViewCell: UITableViewCell {
//MARK: -cell Outlets
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentLabel: UILabel!
    
//MARK: -cell functions
    func setCell(student: Student) {
        self.studentImage.image = student.studentImage
        self.studentLabel.text = student.firstName + " " + student.lastName
        
    }

}
