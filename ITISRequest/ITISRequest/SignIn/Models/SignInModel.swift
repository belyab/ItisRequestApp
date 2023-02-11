//
//  SignInModel.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 07.04.2022.
//

import Foundation
import Firebase

protocol SignInModelDelegate: class {
    func didSignIn()
}

class SignInModel {
    
    weak var delegate: SignInModelDelegate?
    let db = Firestore.firestore()
    var user: AuthDataResult?
    
    func signIn(with email: String, password: String, completion: @escaping ((Result<AuthDataResult?, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(user))
                self.user = user
            }
        }
    }
    
    func getCurrentUserRole(userResult: AuthDataResult) -> String {
        
        var role = "no role21"
        
        let userRef = db.collection("users").document(userResult.user.email!)
        print("EMAIL \(userRef.documentID)")
        userRef.getDocument { documentSnapshot, error in
            
            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                
                role = data["role"] as? String ?? "No role"
            }
        }
        
        return role
    }
    
}
