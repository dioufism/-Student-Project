//
//  StudentDetailiewController.swift
//  new student Project
//
//  Created by ousmane diouf on 9/27/20.
//

import UIKit

class StudentDetailiewController: UIViewController {

//MARK: -Class VAriables
    weak var studentDetailDelegate: SendStudentDelegate?
    var studentObj: Student?
    var detailIndexPath: IndexPath?
    
    @IBOutlet weak var detailedImage: UIImageView!
    @IBOutlet weak var detailedLabel: UILabel!
    @IBOutlet weak var detailPhoneNumber: UILabel!
    @IBOutlet weak var detailedEmail: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
       
    }
    
    func setupDetail() {
        detailedImage.image = studentObj?.studentImage
        detailedLabel.text = studentObj!.firstName + " " + studentObj!.lastName
        detailPhoneNumber.text = studentObj?.phoneNumber
        detailedEmail.text = studentObj?.email
        
    }
    
    
    @IBAction func editStudent(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let edtitVC = storyboard?.instantiateViewController(identifier: "AddStudentViewController") as? AddStudentViewController else {
            fatalError("identifier mismatch")
        }
        edtitVC.student = studentObj
        edtitVC.studentDelegate = self
        edtitVC.indexAtRow = detailIndexPath
        self.navigationController?.pushViewController(edtitVC, animated: true)
    }
}


extension StudentDetailiewController: SendStudentDelegate {
    
    func addStudent(image: UIImage, firstName: String, lName: String, phoneNumber: String, email: String, indexPath: IndexPath?) {
        detailedImage.image = image
        detailedLabel.text = firstName + " " + lName
        detailPhoneNumber.text = phoneNumber
        detailedEmail.text = email
        studentDetailDelegate?.addStudent(image: image, firstName: firstName, lName: lName, phoneNumber: phoneNumber, email: email, indexPath: nil)
    }
    
    
}
