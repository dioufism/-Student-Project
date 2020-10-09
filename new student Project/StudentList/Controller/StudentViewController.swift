//
//  StudentViewController.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import UIKit

class StudentViewController: UIViewController, SendStudentDelegate {
    //MARK: - Implementation of Protocol
    func addStudent(image: UIImage, firstName: String, lName: String, phoneNumber: String, email: String, indexPath: IndexPath?) {
        let newstudent = Student(image: image, firstName: firstName, lastName: lName, email: email, phoneNumber: phoneNumber)
        if let index = indexPath {
            dataSource[index.row] = newstudent // handling dupplicate
        }
        else {
            dataSource.append(newstudent)
        }
        studentTableView.reloadData()
    }
    //MARK: - Outlets
    @IBOutlet weak var studentTableView: UITableView!
    //MARK: - Class Variable
    var dataSource: [Student] = []
    var studentDataDictionary = [String: [Student]]() {
        didSet {
            self.studentTableView.reloadData()
        }
    }
    var studentSectionTitle = [String]() {
        didSet {
            self.studentTableView.reloadData()
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTableView.tableFooterView = UIView()
        self.title = "Students"
        for student in dataSource {
            let studentKey = String(student.firstName.prefix(1))
            if var studentValues = studentDataDictionary[studentKey] {
                studentValues.append(student)
                studentDataDictionary[studentKey] = studentValues }
                else  {
                    self.studentDataDictionary[studentKey] = [student]
                }
        }
        studentSectionTitle = [String](studentDataDictionary.keys)
        studentSectionTitle = studentSectionTitle.sorted(by: {$0 < $1 })
    }
    
    //MARK: -SegueWay implementation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddStudent" {
            let destinationVc = segue.destination as! AddStudentViewController
            destinationVc.studentDelegate = self
        }
    }
}
//MARK: - Extentions
extension StudentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentAtRow = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListTableViewCell") as?  StudentListTableViewCell
        else {fatalError("cannot dequeue cell")}
        cell.setCell(student: studentAtRow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count == 0 {
            self.studentTableView.setEmptyMessage(" there are currently no Student right Now \n Please add new Students")
        }
        else {
            self.studentTableView.restore()
        }
        return dataSource.count
    }
}
extension StudentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(identifier: "toDetailScreen") as StudentDetailViewController
        detailViewController.studentObj = dataSource[indexPath.row]
        detailViewController.studentDetailDelegate = self
        detailViewController.detailIndexPath = indexPath
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}



