//
//  LoginViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class LoginViewController: ViewController {
    let toGroupsSegueID = "ToGroupsSegue"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func pressedLogIn(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error logging in an existing user for Email/Password \(error)")
                return
            }
            
            print("It worked, logged in an existion account")
            print("Email is \(authResult!.user.email)")
            print("UID is \(authResult!.user.uid)")
            
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
