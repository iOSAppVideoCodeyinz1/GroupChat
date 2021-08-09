//
//  GroupsTableViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class GroupsTableViewController: UITableViewController {
    var groups = [Group]()
    var groupCellIdentifier = "GroupCell"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))
        groups.append(Group(name: "test1", emails: "email1"))
//        groups.append(Group(name: "testGroup1", emails: ["1@1.com", "testUser1@example.com"]))
//        groups.append(Group(name: "testGroup1", emails: ["1@1.com"]))
//        groups.append(Group(name: "testGroup1", emails: ["1@1.com", "testUser1@example.com", "testUser2@example.com"]))
    }
    
    @objc func addGroup(){
        print("pressed add Group")
        let alertController = UIAlertController(title: "Create a new Group", message: "", preferredStyle: UIAlertController.Style.alert)

        //configure

        alertController.addTextField { textfield in
            textfield.placeholder = "Group Name"
        }

        alertController.addTextField { textfield in
            textfield.placeholder = "Member Emails"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let submitAction = UIAlertAction(title: "Create Group", style: .default) { (action) in
            //TODO: Add a quote
            let groupNameTextField = alertController.textFields![0] as UITextField
            let emailsTextField = alertController.textFields![1] as UITextField
            print(groupNameTextField.text!)
            print(emailsTextField.text!)
            
            let newGroup = Group(name: groupNameTextField.text!, emails: emailsTextField.text!)
            self.groups.insert(newGroup, at: 0)
            self.tableView.reloadData()
//            self.movieQuotesRef.addDocument(data: [
//                "quote": quoteTextField.text,
//                "movie": movieTextField.text,
//                "created": Timestamp.init(),
//                "author": Auth.auth().currentUser!.uid
//            ])

        }
        
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: groupCellIdentifier, for: indexPath)
        //configure cell
        cell.textLabel?.text = groups[indexPath.row].name
        return cell
    }
    
}
