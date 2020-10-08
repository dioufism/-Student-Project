//
//  AddStudentTableViewCell.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import UIKit

class AddStudentTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextfield: UITextField!
    var temptext: String?

    //MARK: - Helper Functions
    func setupUI(label: String, text: String) {
        cellLabel.text =  label
        cellTextfield.text = text
    }
}
