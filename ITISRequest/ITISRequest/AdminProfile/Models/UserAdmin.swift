//
//  UserAdmin.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 04.06.2022.
//

import Foundation
import Firebase

//struct User {
//    var name: String?
//    var groupNumber: String?
//    var email: String?
//    var phoneNumber : String?
//    var surname : String?
//    var imageURL: String?
//}

class UserAdminService {
    
    // MARK: - Properties
    let email = Auth.auth().currentUser!.email
    let db = Firestore.firestore()
    
    // MARK: - Functions
    func getName(completion: @escaping((String) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in

            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }

                let name = data["name"] as? String ?? "No name"
                completion(name)
            }
        }
    }
    
    func getSurname(completion: @escaping((String) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in

            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }

                let surname = data["surname"] as? String ?? "No surname"
                completion(surname)
            }
        }
    }
    
    func getGroupNumber(completion: @escaping((String) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in

            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }

                let groupNumber = data["groupNumber"] as? String ?? "No group number"
                completion(groupNumber)
            }
        }
    }
    
    func getPhoneNumber(completion: @escaping((String) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in

            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }

                let phoneNumber = data["phoneNumber"] as? String ?? "No phone number"
                completion(phoneNumber)
            }
        }
    }
    
    func getEmail(completion: @escaping((String) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in

            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }

                let email = data["email"] as? String ?? "No email"
                completion(email)
            }
        }
    }
    
    func getAdminEvents(completion: @escaping(([String]) -> ())) {
        let usersRef = db.collection("users").document(email!)

        usersRef.getDocument { documentSnapshot, error in
            if error == nil {
                guard let snapshot = documentSnapshot, snapshot.exists else { return }
                guard let data = snapshot.data() else { return }
                var events = [String]()
                events = data["createdEvents"] as! [String]


                completion(events)
            }
        }
    }
    
    func addEvent(event: Event) -> Bool {
        var result = true
        var newEventRef: DocumentReference? = nil
        newEventRef = db.collection("events").addDocument(data: [
            "eventDateTime": event.eventDateTime,
            "eventDescription" : event.eventDescription,
            "eventMaxMemberCount" : event.eventMaxMemberCount,
            "eventMembersCount" : event.eventMembersCount,
            "eventName" : event.eventName,
            "eventNote" : event.eventNote ?? "",
            "eventPlace" : event.eventPlace,
            "eventScoreCount" : event.eventScoreCount,
            "eventType" : event.eventType,
            "createdUserEmail" : email
        ]) { [self] err in
            if let err = err {
                print("Error adding document: \(err)")
                result = false
            } else {
                print("Document added with ID: \(newEventRef!.documentID)")
                let userRef = self.db.collection("users").document(self.email!)
                userRef.updateData([
                    "createdEvents": FieldValue.arrayUnion([newEventRef!.documentID])
                ])
            }
        }
        return result
    }
    
    func updateName(newName: String) -> Bool {
        let usersRef = db.collection("users").document(email!)
        var result = true
        usersRef.updateData(["name" : newName]) { error in
            guard error == nil else {
                result = false
                return
            }
        }
        return result
    }
    
    func updateSurname(newSurname: String) -> Bool {
        let usersRef = db.collection("users").document(email!)
        var result = true
        usersRef.updateData(["surname" : newSurname]) { error in
            guard error == nil else {
                result = false
                return
            }
        }
        return result
    }
    
    func updateGroupNumber(newGroupNumber: String) -> Bool {
        let usersRef = db.collection("users").document(email!)
        var result = true
        usersRef.updateData(["groupNumber" : newGroupNumber]) { error in
            guard error == nil else {
                result = false
                return
            }
        }
        return result
    }
    
    func updateEmail(newEmail: String) -> Bool {
        let usersRef = db.collection("users").document(email!)
        var result = true
        usersRef.updateData(["email" : newEmail]) { error in
            guard error == nil else {
                result = false
                return
            }
        }
        return result
    }
    
    func updatePhoneNumber(newPhoneNumber: String) -> Bool {
        let usersRef = db.collection("users").document(email!)
        var result = true
        usersRef.updateData(["phoneNumber" : newPhoneNumber]) { error in
            guard error == nil else {
                result = false
                return
            }
        }
        return result
    }
}
