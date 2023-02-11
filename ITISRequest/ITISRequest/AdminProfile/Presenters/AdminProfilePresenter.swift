//
//  AdminProfilePresenter.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 04.06.2022.
//

import Firebase
import Foundation

protocol AdminProfileViewDelegate {
    func reloadData()
    func displayDataName(name: String)
    func displayDataGroupNumber(groupNumber: String)
    func displayDataEmail(email: String)
    func displayDataPhoneNumber(phoneNumber: String)
    func displayDataSurname(surname: String)
}

class AdminProfilePresenter {
    
    // MARK: - Dependencies
    let userService: UserAdminService!
    var eventsUser: [Event]
    var adminProfileViewDelegate: AdminProfileViewDelegate?
    
    // MARK: - Init
    init() {
        userService = UserAdminService()
        eventsUser = [Event]()
    }
    
    func showAdminEvents() {
        
        userService.getAdminEvents(completion:  { [self] events in
            for event in events {
                let FirebaseDatabase = Firestore.firestore()
                FirebaseDatabase.collection("events").document(event).getDocument{ (docSnapshot, error) in
                    if error != nil {
                        print("error with db \(String(describing: error?.localizedDescription))")
                    } else {
                        guard let snapshot = docSnapshot, snapshot.exists else { return }
                        guard let data = snapshot.data() else { return }
                        let eventId = docSnapshot!.documentID
                        let eventDateTime = (data["eventDateTime"] as? Timestamp)?.dateValue()
                        let eventDescription = data["eventDescription"] as? String ?? "No Id"
                        let eventName = data["eventName"] as? String ?? "No Id"
                        let eventMaxMemberCount = data["eventMaxMemberCount"] as? Int
                        let eventMembersCount = data["eventMembersCount"] as? Int
                        let eventNote = data["eventNote"] as? String ?? "No Id"
                        let eventPlace = data["eventPlace"] as? String ?? "No Id"
                        let eventScoreCount = data["eventScoreCount"] as? Int
                        let eventType = data["eventType"] as? String ?? "No Id"
                        
                        let receivedEvent = Event(eventId: eventId, eventDateTime: eventDateTime!, eventDescription: eventDescription, eventMaxMemberCount: eventMaxMemberCount!, eventMembersCount: eventMembersCount!, eventName: eventName, eventNote: eventNote, eventPlace: eventPlace, eventScoreCount: eventScoreCount!, eventType: eventType)
                        self.eventsUser.append(receivedEvent)
                        print(self.eventsUser)
                        adminProfileViewDelegate?.reloadData()
                    }
                }
            }
        })
    }
    
    func getUserData() {
        getUserName()
        getUserEmail()
        getUserGroupNumber()
        getUserPhoneNumber()
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: email)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}|[0-9]{11}$"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        return phoneNumberTest.evaluate(with: phoneNumber)
    }
    
    func isNameValid(_ name : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: name)
        
    }
    
    func isSurnameValid(_ surname : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: surname)
        
    }
    
    func setAdminProfileViewDelegate(adminProfileViewDelegate: AdminProfileViewDelegate) {
        self.adminProfileViewDelegate = adminProfileViewDelegate
    }
    
    func dateString(eventDateTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: eventDateTime)
    }
    
    func getUserEmail() {
        userService.getEmail { [self] email in
            self.adminProfileViewDelegate?.displayDataEmail(email: email)
        }
    }
    
    func getUserSurname() {
        userService.getEmail { [self] surname in
            self.adminProfileViewDelegate?.displayDataSurname(surname: surname)
        }
    }
    
    func getUserName() {
        userService.getName { [self] name in
            self.adminProfileViewDelegate?.displayDataName(name: name)
        }
    }
    
    
    func getUserGroupNumber() {
        userService.getGroupNumber {[self] groupNumber in
            self.adminProfileViewDelegate?.displayDataGroupNumber(groupNumber: groupNumber)
        }
    }
    
    func getUserPhoneNumber() {
        userService.getPhoneNumber {[self] phoneNumber in
            self.adminProfileViewDelegate?.displayDataPhoneNumber(phoneNumber: phoneNumber)
        }
    }
}
