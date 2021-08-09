//
//  RegisterViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class RegisterViewController: ViewController {
    var fN: String?
    var lN: String?
//    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fN = nil
        lN = nil
    }
    @IBAction func pressedRegister(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        fN = firstName
        lN = lastName
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating a new user for Email/Password \(error)")
                return
            }
            
            print("It worked, new user is created")
            print("Email is \(authResult!.user.email)")
            print("UID is \(authResult!.user.uid)")
            
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            UserManager.shared.addUser(uid: Auth.auth().currentUser!.uid, firstName: self.fN, lastName: self.lN)
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
