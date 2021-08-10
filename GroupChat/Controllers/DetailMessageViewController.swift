//
//  DetailMessageViewController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit
import Firebase

class DetailMessageViewController: UINavigationController {
    var message: Message!
     
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
//        nameLabel.text = message!.name
        emailLabel.text = Auth.auth().currentUser!.email
        print(message)
////        messageLabel.text = message!.body
//        if message!.author == Auth.auth().currentUser!.uid {
//            messageView.backgroundColor = #colorLiteral(red: 0.7664601207, green: 0.9360933304, blue: 0.8102425933, alpha: 1)
//            navigationItem.rightBarButtonItem = editButtonItem
//        } else {
//            messageView.backgroundColor = #colorLiteral(red: 0.7305004597, green: 0.9096532464, blue: 0.9937673211, alpha: 1)
//        }
    }
    
    
}
