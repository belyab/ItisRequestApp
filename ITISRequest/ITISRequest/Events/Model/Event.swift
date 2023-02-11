import Foundation
import Firebase

struct Event {
    var eventId: String?
    var eventDateTime: Date?
    var eventDescription: String?
    var eventMaxMemberCount: Int?
    var eventMembersCount : Int?
    var eventName : String?
    var eventNote : String?
    var eventPlace : String?
    var eventScoreCount : Int?
    var eventType : String?
    
}

class EventService {
    
    //Properties
    let email = Auth.auth().currentUser!.email
    let db = Firestore.firestore()
    
    //Dependencies
    var DocRefernce: DocumentReference!
    
    //Functions
    func updateUserEvent(eventId: String) {
        DocRefernce = db.collection("users").document(email!)
        DocRefernce.updateData(["events": FieldValue.arrayUnion([eventId])])
        { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    func updateEventUser(eventId: String) {
        DocRefernce = db.collection("events").document(eventId)
        DocRefernce.updateData(["users": FieldValue.arrayUnion([email!])])
        { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
        print(eventId)
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
    
    func updateEventMaxMemberCount(eventMaxMemberCount: Int, eventId: String) {
        DocRefernce = db.collection("events").document(eventId)
        DocRefernce.updateData(["eventMaxMemberCount": eventMaxMemberCount])
        { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    func updateEventMembersCount(eventMembersCount: Int, eventId: String) {
        DocRefernce = db.collection("events").document(eventId)
        DocRefernce.updateData(["eventMembersCount": eventMembersCount])
        { error in
            guard error != nil else {
                print(error?.localizedDescription)
                return
            }
        }
    }
}

