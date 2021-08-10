//
//  MemberPageController.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import UIKit

class MemberPageController: UITableViewController {
//    var group: Group
    var list: String! = ""
    
    override func viewDidLoad() {
//        let list = group?.raw
        print("list:\(list) \(UserManager.shared.name)")
        navigationItem.rightBarButtonItem = editButtonItem
        
    }
}
