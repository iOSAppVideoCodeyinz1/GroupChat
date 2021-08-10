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
    
    @IBAction func pressedMemberButton(_ sender: Any) {
        performSegue(withIdentifier: "toMembersSegue", sender: self)
    }
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
                    let data = documentSnapshot.data()
                    print(data)
                    let check = data["raw"] as! String
                    let list = check.components(separatedBy: " ")
                    if(list.contains(Auth.auth().currentUser!.email!)){
                        self.groups.append(Group(documentSnapshot: documentSnapshot))
                        self.tableView.reloadData()
                    }
                   
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
            var emails = emailsTextField.text!.components(separatedBy: ", ")
            emails.append(Auth.auth().currentUser!.email!)
            let eStr = emails.joined(separator: " ")
            self.groupsRef.addDocument(data: [
                "name": groupNameTextField.text!,
                "memberEmail": emails,
                "created": Timestamp.init(),
                "author": Auth.auth().currentUser!.uid,
                "ownerEmail": Auth.auth().currentUser!.email,
                "raw": eStr
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupToDelete = groups[indexPath.row]
            
            groupsRef.document(groupToDelete.id).delete()
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return groups[indexPath.row].author == Auth.auth().currentUser?.uid
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var tempG: Group?
//        if let indexPath = tableView.indexPathForSelectedRow {
//            print("passing data ___________ \(groups[indexPath.row])")
//            tempG = groups[indexPath.row]
//        }
        if segue.identifier == toMessageSegueID {
            print("passing data dadafdafdafdafd \(tableView.indexPathForSelectedRow)")
            if let indexPath = tableView.indexPathForSelectedRow {
                print("passing data ___________ \(groups[indexPath.row])")
                (segue.destination as! MessagePageController).group = groups[indexPath.row]
            }
        }
        
//        if segue.identifier == "toMembersSegue" {
//            print("passing data dadafdafdafdafd \(tempG)")
//            let memController = segue.destination as! MemberPageController
//            memController.list = "worked"
//        }
        
    }
    
    
}
