//
//  UserManager.swift
//  GroupChat
//
//  Created by Theo Yin on 8/9/21.
//

import Foundation
import Firebase
let kCollectionUsers = "Users"
let kKeyFN = "First Name"
let kKeyLN = "Last Name"

class UserManager {
    var _collectionRef: CollectionReference
    var name: String?
    static let shared = UserManager()
    var _document: DocumentSnapshot?
    var _userListener: ListenerRegistration?
    
    
    
    private init(){
        _collectionRef = Firestore.firestore().collection(kCollectionUsers)
    }
    
    
    
    //CRUD
    //Creat
    func addUser(uid: String, firstName: String?, lastName: String?, email: String){
        //Get the user if exists
        //add only not exist
        let userRef = _collectionRef.document(uid)
        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error getting user: \(error)")
                return
            }
            if let documentSnapshot = documentSnapshot {
                if (documentSnapshot.exists) {
                    print("There is alreaady a User Object for this auth User. Do nothing")
                    return
                } else {
                    print("Create a User with doc id \(uid)")
                    userRef.setData([
                        kKeyFN: firstName ?? "",
                        kKeyLN: lastName ?? ""
                    ])
                }
            }
        }
        self.name = "\(firstName as! String) \(lastName as! String)"
    }
    //Read
    func beginListening(uid: String, changeListener: (() -> Void)?) {
        let userRef = _collectionRef.document(Auth.auth().currentUser!.uid)
        userRef.addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error listening for user: \(error)")
                return
            }
            if let documentSnapshot = documentSnapshot {
                self._document = documentSnapshot
                changeListener?()
            }
        }
    }
    
    func stopListening() {
        _userListener?.remove()
    }
    //Update
    func updateName(fName: String, lName: String){
        let userRef = _collectionRef.document(Auth.auth().currentUser!.uid)
        userRef.updateData([kKeyFN : fName, kKeyLN: lName])
    }
    
    //Delete -- no delete!
    
    
    //Getters
    var fName: String {
        get {
            if let value = _document?.get(kKeyFN) {
                return value as! String
            }
            return ""
        }
    }
    var lName: String {
        get {
            if let value = _document?.get(kKeyLN) {
                return value as! String
            }
            return ""
        }
    }
    
    var tname: String {
        return self.name as! String
    }
    
    
}
