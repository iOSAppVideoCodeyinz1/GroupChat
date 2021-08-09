//
//  RegisterViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class RegisterViewController: ViewController {
    let toGroupsSegueID = "ToGroupsSegue"
    
//    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func pressedRegister(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating a new user for Email/Password \(error)")
                return
            }
            
            print("It worked, new user is created")
            print("Email is \(authResult!.user.email)")
            print("UID is \(authResult!.user.uid)")
            
            
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
