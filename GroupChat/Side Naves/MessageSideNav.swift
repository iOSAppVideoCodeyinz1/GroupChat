//
//  MessageSideNav.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit

class MessageSideNav: UIViewController {
    var tableViewController: MessagePageController{
        let navController = presentingViewController as! UINavigationController
        return navController.viewControllers.last as! MessagePageController
    }
    @IBAction func pressedDeleteButton(_ sender: Any) {
        tableViewController.setEditing(!tableViewController.isEditing, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        tableViewController.performSegue(withIdentifier: "BackToGroupsSegue", sender: self)
    }
}
