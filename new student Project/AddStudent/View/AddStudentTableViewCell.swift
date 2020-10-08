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

extension AddStudentTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = cellTextfield.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let newText = currentText.replacingCharacters(in: stringRange, with: string)
        var count = false
        if newText.hasSuffix(" "){ return false } // empty spaces aren't allowed allowed
        self.cellTextfield.textColor = .black
        
        switch cellLabel.text {
        case "First Name", "Last Name":
            if !newText.isValidName { self.cellTextfield.textColor = .systemPink }
            count = newText.count <= 25
            break
            
        case "Number":
            if !newText.isPhoneNumberValid { return false }
            if newText.count <= 8 { self.cellTextfield.textColor = .systemPink }
            count = newText.count <= 12
            break
            
        case "Email":
            if !newText.isValidEmail { self.cellTextfield.textColor = .systemPink }
            count = newText.count <= 25
            break
        default:
            break
        }
        return count
    }
}
