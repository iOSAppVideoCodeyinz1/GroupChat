//
//  Group.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import Foundation
import Firebase
class Group {
    var author: String
    var id: String
    var name: String
    var raw: String
//    var memberEmails: String
    

    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.name = data["name"] as! String
//        self.memberEmails = data["memberEmail"] as! String
        self.author = data["author"] as! String
        self.raw = data["raw"] as! String
    }
}

class Message {
    var body: String
    var author: String
    var name: String
    var id: String
    var email: String

    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.name = data["name"] as! String
        self.author = data["author"] as! String
        self.body = data["body"] as! String
        self.email = data["email"] as! String
        
    }
}
