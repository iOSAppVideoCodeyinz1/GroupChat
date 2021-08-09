//
//  ProfilePageViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit

class ProfilePageViewController: ViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    
    
    @IBAction func pressedUpdateButton(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
