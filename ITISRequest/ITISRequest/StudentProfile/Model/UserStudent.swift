import Foundation
import Firebase

class User: NSObject, NSCoding {
    
    var name: String?
    var groupNumber: String?
    var email: String?
    var phoneNumber : String?
    var surname : String?
    var imageURL: String?
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(groupNumber, forKey: "groupNumber")
        coder.encode(email, forKey: "email")
        coder.encode(phoneNumber, forKey: "phoneNumber")
        coder.encode(surname, forKey: "surname")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        groupNumber = coder.decodeObject(forKey: "groupNumber") as? String ?? ""
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        phoneNumber = coder.decodeObject(forKey: "phoneNumber") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
    }
}

class UserSettings {
    
    private enum SettingsKey: String {
        case user
    }
    
    static var user: User! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.user.rawValue) as? Data , let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? User else { return nil }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.user.rawValue
            
            if let newUser = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: newUser, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}

class UserStudentService {
    
    //Properties
    let id = Auth.auth().currentUser!.uid
    let email = Auth.auth().currentUser!.email
    let db = Firestore.firestore()
    
    //Dependencies
    var DocRefernce:DocumentReference!
    
    func getDataName(completion: @escaping((String) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument {(docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                let name = data["name"] as? String ?? "No name"
                completion(name)
            }
        }
    }
    
    func getUserEvents(completion: @escaping(([String]) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument {(docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                var eventsArray = [String]()
                eventsArray = data["events"] as! [String]
                completion(eventsArray)
            }
        }
    }
    
    func getDataSurname(completion: @escaping((String) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument {(docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                let surname = data["surname"] as? String ?? "No surname"
                print(surname)
                completion(surname)
            }
        }
    }
    
    func getGroupNumber(completion: @escaping((String) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument { (docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                let groupNumber = data["groupNumber"] as? String ?? "No group Number"
                
                completion(groupNumber)
                
            }
        }
    }
    
    func getEmail(completion: @escaping((String) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument { (docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                let email = data["email"] as? String ?? "No email"
                
                completion(email)
            }
        }
    }
    
    
    
    func getPhoneNumber(completion: @escaping((String) -> ())) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.getDocument { (docSnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                guard let snapshot = docSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                let phoneNumber = data["phoneNumber"] as? String ?? "No phone Number"
                
                completion(phoneNumber)
            }
        }
    }
    
    func updateName(name: String) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.updateData(["name": name]) { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    func updateSurname(surname: String) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.updateData(["surname": surname]) { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    func updateGroupNumber(groupNumber: String) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.updateData(["groupNumber": groupNumber]) { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    func updatePhoneNumber(phoneNumber: String) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.updateData(["phoneNumber": phoneNumber]) { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
}
