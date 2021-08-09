//
//  WelcomeViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class WelcomeViewController: ViewController {
    let toGroupsSegueID = "ToGroupsSegue"
    
    var authListenerHandle : AuthStateDidChangeListenerHandle!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
            if(Auth.auth().currentUser == nil){
                print("you messed up, go back to login page")
                self.navigationController?.popViewController(animated: true)
            }else {
                print("Someone is already signed in")
                self.performSegue(withIdentifier: self.toGroupsSegueID, sender: self)
            }
        }
        
        
    }

}
