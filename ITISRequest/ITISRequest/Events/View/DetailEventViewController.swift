import UIKit

protocol DetailEventViewControllerProtocol: AnyObject {
    func showAlert(title: String?, message: String?)
}

class DetailEventViewController: UIViewController {
    
    @IBOutlet private var eventNameLabel: UILabel!
    @IBOutlet private var eventNoteLabel: UILabel!
    @IBOutlet private var eventScoreCountLabel: UILabel!
    @IBOutlet private var eventMaxMembersCountLabel: UILabel!
    @IBOutlet private var eventDescriptionLabel: UILabel!
    @IBOutlet private var eventDateTimeLabel: UILabel!
    @IBOutlet private var eventPlaceLabel: UILabel!
    @IBOutlet private var button: DesignableButton!
    
    //Dependencies
    var eventsPresenter : EventPresenter!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayDetailData()
        
        if eventsPresenter.event.eventMaxMemberCount! <= 0 {
            showAlert(title: "☹️", message: "К сожалению, все участник набраны")
            button.isEnabled = false
        }
    }
    
    //Functions
    func initializePresenter() {
        if eventsPresenter == nil {
            eventsPresenter = EventPresenter()
        }
    }
    
    func displayDetailData() {
        eventNameLabel.adjustsFontSizeToFitWidth = true
        eventNameLabel.text = eventsPresenter.event.eventName
        eventNoteLabel.adjustsFontSizeToFitWidth = true
        eventNoteLabel.text = eventsPresenter.event.eventNote
        eventDescriptionLabel.adjustsFontSizeToFitWidth = true
        eventDescriptionLabel.text = eventsPresenter.event.eventDescription
        eventPlaceLabel.adjustsFontSizeToFitWidth = true
        eventPlaceLabel.text = eventsPresenter.event.eventPlace
        eventDateTimeLabel.adjustsFontSizeToFitWidth = true
        eventDateTimeLabel.text = eventsPresenter.dateString(eventDateTime: eventsPresenter.event.eventDateTime!)
        eventScoreCountLabel.adjustsFontSizeToFitWidth = true
        eventScoreCountLabel.text = String(describing:eventsPresenter.event.eventScoreCount)
        eventMaxMembersCountLabel.adjustsFontSizeToFitWidth = true
        eventMaxMembersCountLabel.text = String(describing: eventsPresenter.event.eventMaxMemberCount)
    }
    
    // MARK: - IBAction
    @IBAction func button(_ sender: Any) {
        eventsPresenter.entryToEvent()
    }
}

// MARK: - DetailEventViewControllerProtocol

extension DetailEventViewController: DetailEventViewControllerProtocol {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
