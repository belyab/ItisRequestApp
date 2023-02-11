import Foundation
import Firebase

protocol StudentProfileViewDelegate {
    func reloadData()
    func displayDataName(name: String)
    func displayDataGroupNumber(groupNumber: String)
    func displayDataEmail(email: String)
    func displayDataPhoneNumber(phoneNumber: String)
}

class StudentProfilePresenter {
    
    //Dependencies
    private let userStudentService: UserStudentService
    private var studentProfileViewDelegate: StudentProfileViewDelegate?
    var eventsUser = [Event]()
    var event: Event!
    
    // MARK: - Init
    init(userStudentService:UserStudentService){
        self.userStudentService = userStudentService
    }
    
    func showUserEvents(){
        userStudentService.getUserEvents(completion: {
            [self] eventsArray in
            for i in eventsArray {
                let FirebaseDatabase = Firestore.firestore()
                FirebaseDatabase.collection("events").document(i).getDocument{ (docSnapshot, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        print("error")
                    } else {
                        guard let snapshot = docSnapshot, snapshot.exists else { return }
                        guard let data = snapshot.data() else { return }
                        let eventId = docSnapshot!.documentID as? String
                        let eventDateTime = (data["eventDateTime"] as? Timestamp)?.dateValue()
                        let eventDescription = data["eventDescription"] as? String ?? "No Id"
                        let eventName = data["eventName"] as? String ?? "No Id"
                        let eventMaxMemberCount = data["eventMaxMemberCount"] as? Int
                        let eventMembersCount = data["eventMembersCount"] as? Int
                        let eventNote = data["eventNote"] as? String ?? "No Id"
                        let eventPlace = data["eventPlace"] as? String ?? "No Id"
                        let eventScoreCount = data["eventScoreCount"] as? Int
                        let eventType = data["eventType"] as? String ?? "No Id"
                        
                        let event = Event(eventId: eventId!, eventDateTime: eventDateTime!, eventDescription: eventDescription, eventMaxMemberCount: eventMaxMemberCount!, eventMembersCount: eventMembersCount!, eventName: eventName, eventNote: eventNote, eventPlace: eventPlace, eventScoreCount: eventScoreCount!, eventType: eventType)
                        eventsUser.append(event)
                        print(eventsUser)
                        studentProfileViewDelegate?.reloadData()
                    }
                    
                }
            }
        })
    }
    
    func setViewDelegate(studentProfileViewDelegate:StudentProfileViewDelegate?){
        self.studentProfileViewDelegate = studentProfileViewDelegate
    }
    
    func dateString(eventDateTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: eventDateTime)
    }
    
    func getUserName() {
        userStudentService.getDataName {[self] name in
            self.studentProfileViewDelegate?.displayDataName(name: name)
        }
    }
    
    func getUserEmail() {
        userStudentService.getEmail {[self] email in
            self.studentProfileViewDelegate?.displayDataEmail(email: email)
        }
    }
    
    func getUserGroupNumber() {
        userStudentService.getGroupNumber {[self] groupNumber in
            self.studentProfileViewDelegate?.displayDataGroupNumber(groupNumber: groupNumber)
        }
    }
    
    func getUserPhoneNumber() {
        userStudentService.getPhoneNumber {[self] phoneNumber in
            self.studentProfileViewDelegate?.displayDataPhoneNumber(phoneNumber: phoneNumber)
        }
    }
    
    func isNameValid(_ name : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: name)
        
    }
    
    func isSurnameValid(_ surname : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: surname)
        
    }
    
    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@","^[0-9]{10}|[0-9]{11}$")
        return regex.evaluate(with: phoneNumber)
    }
}
