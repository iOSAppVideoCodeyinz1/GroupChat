//
//  SideNavViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class SideNavViewController: UIViewController {
    
    var tableViewController: GroupsTableViewController{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! GroupsTableViewController
    }
    
    @IBAction func pressedEditProfile(_ sender: Any) {
        print("profile")
    }
    
    @IBAction func pressedDeleteGroups(_ sender: Any) {
        print("editing mode \(tableViewController.isEditing)")
        tableViewController.setEditing(!tableViewController.isEditing, animated: true)
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressedLogOut(_ sender: Any) {
        print("auth sign out")
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error")
        }
        dismiss(animated: true, completion: nil)
    }
}
