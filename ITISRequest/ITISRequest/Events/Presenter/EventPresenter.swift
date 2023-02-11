import Foundation
import Firebase

protocol EventPresenterProtocol {
    func dateString(eventDateTime: Date) -> String
    func showEvents()
    func entryToEvent()
    
}

class EventPresenter {
    
    //Dependencies
    weak var view: EventsViewProtocol?
    private let eventService: EventService
    private var eventPresenterProtocol : EventPresenterProtocol?
    var eventsArray = [Event]()
    var event: Event!
    
    // MARK: - Init
    init(view: EventsViewProtocol) {
        self.view = view
        self.eventService = EventService()
    }
    
    init() {
        self.eventService = EventService()
    }
    
}

// MARK: - EventPresenterProtocol

extension EventPresenter: EventPresenterProtocol {
    
    func dateString(eventDateTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: eventDateTime)
    }
    
    func showEvents(){
        let FirebaseDatabase = Firestore.firestore()
        FirebaseDatabase.collection("events").order(by: "eventDateTime", descending: true)
            .addSnapshotListener { [self] querySnapshot, error in
                
                if error != nil{
                    print(error?.localizedDescription)
                } else {
                    if querySnapshot?.isEmpty != true && querySnapshot != nil {
                        self.eventsArray.removeAll(keepingCapacity: false)
                        for document in querySnapshot!.documents {
                            if let eventName = document.get("eventName") as? String {
                                if let eventPlace = document.get("eventPlace") as? String {
                                    if let eventNote = document.get("eventNote") as? String {
                                        if let eventScoreCount = document.get("eventScoreCount") as? Int {
                                            if let eventDescription = document.get("eventDescription") as? String {
                                                if let eventDateTime = (document.get("eventDateTime") as? Timestamp)?.dateValue() {
                                                    if let eventType = document.get("eventType") as? String {
                                                        if let eventMaxMemberCount = document.get("eventMaxMemberCount") as? Int {
                                                            if let eventMembersCount = document.get("eventMembersCount") as? Int {
                                                                if let eventId = document.documentID as? String {
                                                                    
                                                                    let event = Event(eventId: eventId, eventDateTime: eventDateTime, eventDescription: eventDescription, eventMaxMemberCount: eventMaxMemberCount, eventMembersCount: eventMembersCount, eventName: eventName, eventNote: eventNote, eventPlace: eventPlace, eventScoreCount: eventScoreCount, eventType: eventType)
                                                                    eventsArray.append(event)
                                                                    print(eventsArray)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    view?.reloadData()
                }
            }
    }
    
    func entryToEvent() {
        eventService.getUserEvents {
            [self] eventsArray in
            
            if eventsArray.contains(String(describing:event.eventId) ) {
                view?.showAlert(title: "🤪", message: "Вы уже записались на это мероприятие")
            } else {
                eventService.updateUserEvent(eventId: (event.eventId!))
                eventService.updateEventUser(eventId: (event.eventId!))
                event.eventMaxMemberCount! -= 1
                event.eventMembersCount! +=  1
                eventService.updateEventMaxMemberCount(eventMaxMemberCount: (event.eventMaxMemberCount!), eventId: event.eventId!)
                eventService.updateEventMembersCount(eventMembersCount: (event.eventMembersCount!), eventId: event.eventId!)
            }
        }
    }
    
}


