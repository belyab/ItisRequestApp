//
//  CheckCodeModel.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 03.06.2022.
//

import Firebase

protocol CheckCodeModelDelegate: AnyObject {
    func checkCode(code: String) -> Bool
}

class CheckCodeModel {
    
    // MARK: - Properties
    weak var delegate: CheckCodeModelDelegate?
    let id = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    // MARK: - Functions
    func check(with code: String) -> Bool {
        let collection = db.collection("users").document(id)
        var defaultCode = "no code"
        
        collection.getDocument { (docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                defaultCode = data["code"] as? String ?? "no code"
            }
            
        }
        return defaultCode == code
    }
}
