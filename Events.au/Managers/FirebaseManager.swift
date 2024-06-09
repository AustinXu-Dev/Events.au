//
//  FirebaseManager.swift
//  Events.au
//
//  Created by Akito Daiki on 09/06/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager: NSObject {
    
    let auth: Auth
    let currentUser: String
    let firebaseApp: FirebaseApp?
    
    static let shared = FirebaseManager()
    
    override init(){
        
        self.auth = Auth.auth()
        self.currentUser = Auth.auth().currentUser?.uid ?? ""
        self.firebaseApp = FirebaseApp.app()
        
        super.init()
    }
}
