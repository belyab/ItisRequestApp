import UIKit

protocol UserDetailEventsViewControllerProtocol: AnyObject {
    func showAlert(title: String?, message: String?)
}

class UserDetailEventsViewController: UIViewController {
    
    @IBOutlet private var eventNameLabel: UILabel!
    @IBOutlet private var eventNoteLabel: UILabel!
    @IBOutlet private var eventScoreCountLabel: UILabel!
    @IBOutlet private var eventMaxMembersCountLabel: UILabel!
    @IBOutlet private var eventDescriptionLabel: UILabel!
    @IBOutlet private var eventDateTimeLabel: UILabel!
    @IBOutlet private var eventPlaceLabel: UILabel!
    
    //Dependencies
    var studentProfilePresenter : StudentProfilePresenter!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayDetailData()
    }
    
    //Functions
    func initializePresenter() {
        if studentProfilePresenter == nil {
            studentProfilePresenter =  StudentProfilePresenter(userStudentService: UserStudentService())
        }
    }
    
    func displayDetailData() {
        eventNameLabel.text = studentProfilePresenter.event.eventName
        eventNoteLabel.text = studentProfilePresenter.event.eventNote
        eventDescriptionLabel.text = studentProfilePresenter.event.eventDescription
        eventPlaceLabel.text = studentProfilePresenter.event.eventPlace
        eventDateTimeLabel.text = studentProfilePresenter.dateString(eventDateTime: studentProfilePresenter.event.eventDateTime!)
        eventScoreCountLabel.text = String(describing:studentProfilePresenter.event.eventScoreCount)
        eventMaxMembersCountLabel.text = String(describing: studentProfilePresenter.event.eventMaxMemberCount)
    }
}

// MARK: - DetailEventViewControllerProtocol
extension UserDetailEventsViewController: UserDetailEventsViewControllerProtocol {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
