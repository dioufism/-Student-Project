//
//  StudentViewController.swift
//  new student Project
//
//  Created by ousmane diouf on 9/26/20.
//

import UIKit

class StudentViewController: UIViewController, SendStudentDelegate {
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
    
    @IBOutlet weak var studentTableView: UITableView!
    
    var dataSource: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentTableView.tableFooterView = UIView()
        self.title = "Students"
        dataSource = createData()
        
    }
    
    
    func createData() -> [Student] {
        
        var tempData: [Student] = []
        
        let student1 = Student(image: #imageLiteral(resourceName: "icons8-user_groups") , firstName: "Ousmane", lastName: "Diouf", email: "dioufism@gmai.com", phoneNumber: "985547558")
        let student2 = Student(image: #imageLiteral(resourceName: "icons8-user_groups"), firstName: "Dior", lastName: "Diouf", email: "dior@gmai.com", phoneNumber: "985547558")
        let student3 = Student(image: #imageLiteral(resourceName: "icons8-user_groups"), firstName: "jamicka", lastName: "Diouf", email: "jamicka@gmai.com", phoneNumber: "985547558")
        let student4 = Student(image: #imageLiteral(resourceName: "icons8-user_groups"), firstName: "sandra", lastName: "Diouf", email: "sandra@gmai.com", phoneNumber: "985547558")
        
        tempData.append(student1); tempData.append(student2); tempData.append(student3); tempData.append(student4);
        
        return tempData
    }
    
    //MARK: -SegueWay implementation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddStudent" {
            let destinationVc = segue.destination as! AddStudentViewController
            destinationVc.studentDelegate = self
        }
    }
}


extension StudentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentAtRow = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListTableViewCell") as?  StudentListTableViewCell
        else {fatalError("cannot dequeue cell")}
        cell.setCell(student: studentAtRow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension StudentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(identifier: "toDetailScreen") as StudentDetailiewController
        detailViewController.studentObj = dataSource[indexPath.row]
        detailViewController.studentDetailDelegate = self
        //fix edit
        detailViewController.detailIndexPath = indexPath
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}



