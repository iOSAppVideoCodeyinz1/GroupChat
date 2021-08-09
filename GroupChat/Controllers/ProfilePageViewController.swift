//
//  ProfilePageViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class ProfilePageViewController: ViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.beginListening(uid: Auth.auth().currentUser!.uid, changeListener: updateView)
        emailLabel.text = Auth.auth().currentUser!.email
        
    }
    
    @IBAction func pressedUpdateButton(_ sender: Any) {
        
        print("Send Name to Firebase \(fNameTextField.text) \(lNameTextField.text)")
        UserManager.shared.updateName(fName: fNameTextField.text!, lName: lNameTextField.text!)
//        dismiss(animated: true, completion: nil)
    }
    
    func updateView(){
        fNameTextField.text = UserManager.shared.fName
        lNameTextField.text = UserManager.shared.lName
        
    }
}
