import Foundation
import Firebase

class SignUpModel {
    
    func signUp(
        surname: String,
        name: String,
        email: String,
        password: String,
        phoneNumber: String,
        groupNumber: String,
        onSuccess: @escaping () -> Void,
        onError: @escaping (_ error: Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if  error != nil {
                print(error!.localizedDescription)
                onError(error!)
                return
            }
            let dataBase = Firestore.firestore()
            var ref: DocumentReference? = nil
            let data: [String : Any] = [
                "email" : email,
                "surname": surname,
                "name": name,
                "phoneNumber": phoneNumber,
                "groupNumber": groupNumber,
                "events" : [ ]
            ]
            
            dataBase.collection("users").document(email).setData(data) { err in
                if  error != nil {
                    print("Error adding document: \(error?.localizedDescription)")
                    onError(error!)
                } else {
                    onSuccess()
                }
            }            
        }
    }
}

