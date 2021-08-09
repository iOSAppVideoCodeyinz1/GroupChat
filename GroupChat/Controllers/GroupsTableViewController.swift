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
    var toMessageSegueID = "ToMessageSegue"
    
    var groupsRef: CollectionReference!
    var groupListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))
        groupsRef = Firestore.firestore().collection("Groups")
        //        groups.append(Group(name: "testGroup1", emails: ["1@1.com", "testUser1@example.com"]))
        //        groups.append(Group(name: "testGroup1", emails: ["1@1.com"]))
        //        groups.append(Group(name: "testGroup1", emails: ["1@1.com", "testUser1@example.com", "testUser2@example.com"]))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startlistening()
    }
    
    
    func startlistening(){
        if(groupListener != nil) {
            groupListener.remove()
        }
        var query = groupsRef.order(by: "created", descending: true).limit(to: 50)
        
        groupListener = query.addSnapshotListener { querySnapshot, error in
            if querySnapshot != nil {
                self.groups.removeAll()
                querySnapshot?.documents.forEach({ documentSnapshot in
                    print(documentSnapshot.documentID)
                    print(documentSnapshot.data())
                    self.groups.append(Group(documentSnapshot: documentSnapshot))
                    self.tableView.reloadData()
                })
            } else {
                print("Error getting movie quotes \(error!)")
            }
        }
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


            self.groupsRef.addDocument(data: [
                "name": groupNameTextField.text!,
                "memberEmail": Auth.auth().currentUser!.email  ,
                "created": Timestamp.init(),
                "author": Auth.auth().currentUser!.uid
            ])

            
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toMessageSegueID {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! MessagePageController).group = groups[indexPath.row]
            }
        }
    }
}
