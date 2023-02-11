//
//  SignInForAdminService.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 03.06.2022.
//

import Foundation
import Firebase

class SignInForAdminService {
    
    let id = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    func checkCode(code: String) -> String{
        let collection = db.collection("users").document(id)
        var role = "no role"
        
        collection.getDocument { (docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                role = data["role"] as? String ?? "no role"
            }
            
        }
        
        return role
    }
    
}
