//
//  MessagePageController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class FromMeMessageCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel?
}

class NotFromMeMessageCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
}

class MessagePageController: UITableViewController{
    var messages = [Message]()
    var group: Group?
    var messagesRef: CollectionReference?
    var kFromMeMessageCell = "FromMeMessageCell"
    var kNotFromMeMessageCell = "NotFromMeMessageCell"
    var messagesListener: ListenerRegistration!
    let toMessageDetailSegueID = "ToMessageDetailSegue"
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preppppppp-------------------------")
        if segue.identifier == "toMessageDetailSegue1" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! DetailMessageViewController).message = messages[indexPath.row]
            }
        }
        if segue.identifier == "toMessageDetailSegue2" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! DetailMessageViewController).message = messages[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("name is \(UserManager.shared.tname)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(showAddMessageDialog))
        messagesRef = Firestore.firestore().collection("Groups").document(group!.id).collection("Messages")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startListening()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        messagesListener.remove()
    }
    func startListening() {
        if(messagesListener != nil) {
            messagesListener.remove()
        }
        var query = messagesRef!.order(by: "created", descending: true).limit(to: 50)
        
        messagesListener = query.addSnapshotListener { querySnapshot, error in
            if querySnapshot != nil {
                self.messages.removeAll()
                querySnapshot?.documents.forEach({ documentSnapshot in
                    //                    print(documentSnapshot.documentID)
                    //                    print(documentSnapshot.data())
                    self.messages.insert(Message(documentSnapshot: documentSnapshot), at: 0)
                    self.tableView.reloadData()
                })
            } else {
                print("Error getting messages \(error!)")
            }
        }
    }
    
    @objc func showAddMessageDialog(){
        //todo: CRUD
        
        let alertController = UIAlertController(title: "Create a new Message", message: "", preferredStyle: UIAlertController.Style.alert)
        
        //configure
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Message"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            //TODO: Add a quote
            let messageTextField = alertController.textFields![0] as UITextField
            print(messageTextField.text!)


            self.messagesRef!.addDocument(data: [
                "body": messageTextField.text,
                "created": Timestamp.init(),
                "author": Auth.auth().currentUser!.uid,
                "name": "\(UserManager.shared.tname)",
                "email": Auth.auth().currentUser!.email
            ])
            
        }
        
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messages[indexPath.row].author == Auth.auth().currentUser!.uid {
            let cell = tableView.dequeueReusableCell(withIdentifier: kFromMeMessageCell, for: indexPath) as! FromMeMessageCell
            cell.messageLabel!.text = messages[indexPath.row].body
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kNotFromMeMessageCell, for: indexPath) as!NotFromMeMessageCell
            cell.messageLabel!.text = messages[indexPath.row].body
            cell.authorLabel!.text = messages[indexPath.row].name
            
            return cell
        }
       
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            print("Delete this quote")
            //            movieQuotes.remove(at: indexPath.row)
            //            tableView.reloadData()
            let messageToDelete = messages[indexPath.row]
            messagesRef!.document(messageToDelete.id).delete()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let message = messages[indexPath.row]
        return Auth.auth().currentUser!.uid == message.author
    }
    
}



