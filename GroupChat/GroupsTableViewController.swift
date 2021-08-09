//
//  GroupsTableViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class GroupsTableViewController: UITableViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
    }
    
    @objc func signOut(){
        print("pressed sign out")
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error")
        }
    }
    
}
