//
//  AddStudentViewController.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import UIKit

//MARK: -Delegate Protocol
protocol SendStudentDelegate: class {
    func addStudent( image: UIImage,firstName: String, lName: String, phoneNumber: String, email: String, indexPath: IndexPath? )
}

class AddStudentViewController: UIViewController, UITextFieldDelegate {
    enum StudentData: String { //
        case firstName = "First Name"
        case lastName = "Last Name"
        case phoneNumber = "Phone Number"
        case email = "Email"
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var addStudenttable: UITableView!
    @IBOutlet weak var studentNavBar: UINavigationBar!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    //MARK: - CLASS VARIABLES
    var student: Student?
    var studentData: [StudentData] = []  //Array of type enum
    var studentDelegate: SendStudentDelegate?
    var selectedImage: UIImage? = #imageLiteral(resourceName: "icons8-user_groups")  // always set to have a default image
    var indexAtRow: IndexPath? // pass value to this indexpath
    
//MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "student"
        self.addStudenttable.tableFooterView = UIView()
        
        setupProperties()
        setButton()
       }
    //MARK: -HELPER FUNCTION
    func setupProperties() { //order of displaying in the tableView
        studentData.append(.firstName)
        studentData.append(.lastName)
        studentData.append(.phoneNumber)
        studentData.append(.email)
        if let _ = student {
            self.title = "Edit Student"
        } else {
            self.title = "Add Student"
            student = Student()
        }
    }
    private func setupImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate =  self
        imagepicker.allowsEditing =  true
        imagepicker.sourceType = .photoLibrary
        self.present (imagepicker, animated: true,completion: nil)
    }
    
    func setButton() {
        
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.cornerRadius = profileImageButton.bounds.width/8
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.gray.cgColor
    }
    func throwsAlert (title: String, message: String){
        // instantiate the alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    //MARK: -Action Buttons
    @IBAction func ProfileImageButtontapped(_ sender: UIButton) {
        let actionSheet: UIAlertController = UIAlertController(title: "set picture", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { [self] (action) in
            if UIImagePickerController.isSourceTypeAvailable( .camera) {
                setupImagePicker(sourceType: .camera)
            } else {
                let actionSheetForCamera: UIAlertController = UIAlertController(title: "Cannot use camera", message: " would you like to pick image from Photo library? ", preferredStyle: .alert)
                let selected = UIAlertAction(title: "YES", style: .default) { action in
                    self.setupImagePicker(sourceType: .photoLibrary)
                }
                let canelation = UIAlertAction(title: "NO", style:.cancel, handler: nil)
                actionSheetForCamera.addAction(selected)
                actionSheetForCamera.addAction(canelation)
                self.present(actionSheetForCamera, animated: true, completion: nil)
            }
        }
        let actionPhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.setupImagePicker(sourceType: .photoLibrary)
        }
        let canelation = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(camera)
        actionSheet.addAction(actionPhotoLibrary)
        actionSheet.addAction(canelation)
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    @IBAction func saveInfo(_ sender: Any) {
        let cell1 = addStudenttable.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddStudentTableViewCell
        let cell2 = addStudenttable.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddStudentTableViewCell
        let cell3 = addStudenttable.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddStudentTableViewCell
        let cell4 = addStudenttable.cellForRow(at: IndexPath(row: 3, section: 0)) as! AddStudentTableViewCell
        // validate here
        let fName = cell1.cellTextfield.text
        let lName = cell2.cellTextfield.text
        let phoneNumber = cell3.cellTextfield.text
        let email = cell4.cellTextfield.text
        
        if fName?.isEmpty ==  true || fName?.isValidName ==  false {
            throwsAlert(title: "First Name can't be empty", message: "fill the first Name Please")
            
        }
        else if lName?.isEmpty == true {
            throwsAlert(title: "Last Name can't be empty", message: "fil the last name Please")
        }
        else if phoneNumber?.isEmpty == true {
            throwsAlert(title: "Phone Number empty", message: "Provide a Phone Numuber Please")
        }
        else if email?.isEmpty == true {
            throwsAlert(title: "Email can't be empty", message: "Provide an Email Please")
        }
        else if fName?.isEmpty ==  true, lName?.isEmpty == true, phoneNumber?.isEmpty == true, email?.isEmpty == true {
            throwsAlert(title: "fields cannot be empty", message: "fill the fileds please")
        }
        
        else {
            studentDelegate?.addStudent(image: selectedImage! ,firstName: fName!, lName: lName!, phoneNumber: phoneNumber!, email: email!, indexPath: indexAtRow)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

//MARK: -DataSource&Delegate
extension AddStudentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}



extension AddStudentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let studentAtRow = studentData[indexPath.row] // we at row 0  var studentAtRow = ""
        var text = " "
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "AddStudentTableViewCell") as? AddStudentTableViewCell
        else {fatalError("cant dequeue add student cell")}
    
        cell.cellTextfield.keyboardType = .default
        switch studentAtRow {
        case .firstName:
            text = student?.firstName ?? ""
            cell.cellTextfield.autocapitalizationType = .words
            // studentAtRow =
        case .lastName:
            text = student?.lastName ?? ""
            cell.cellTextfield.autocapitalizationType = .words
        case .phoneNumber:
            text = student?.phoneNumber ?? ""
            cell.cellTextfield.autocapitalizationType = .words
        case .email:
            text = student?.email ?? ""
        }
        
        cell.setupUI(label: studentAtRow.rawValue, text: text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studentData.count
    }
}

extension AddStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  { //need navigation controller because there is a controller that we going to have to present
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //get the image that the user has chosen
        if let capturedImage = info[.editedImage] as?  UIImage {
            selectedImage =  capturedImage
          profileImageButton.setImage(capturedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}


