//
//  Group.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import Foundation

class Group {
    var name: String
    var memberEmails: String
    
    init(name: String, emails: String) {
        self.name = name
        self.memberEmails = emails
    }
}
