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
//    var welcomPageListener: ListenerRegistration
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if Auth.auth().currentUser != nil {
//            print("Someone is already signed in")
//            self.performSegue(withIdentifier: self.toGroupsSegueID, sender: self)
//        }
//    }
    
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(authListenerHandle!)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == toGroupsSegueID {
//            //Only segue to check
//            print("Checking for user \(Auth.auth().currentUser!.uid)")
//            UserManager.shared.addUser(uid: Auth.auth().currentUser!.uid, firstName: Auth.auth().currentUser!.displayName, lastName: Auth.auth().currentUser!.displayName)
//        }
//    }
}
