import UIKit
import Firebase

class StudentProfileViewController: UIViewController, StudentProfileViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var groupNumberLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!
    @IBOutlet weak var eventsTabeView: UITableView!
    
    //Dependencies
    private let studentProfilePresenter = StudentProfilePresenter(userStudentService: UserStudentService())

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        eventsTabeView.delegate = self
        eventsTabeView.dataSource = self
        eventsTabeView.register(UINib(nibName: "EventTableViewCell", bundle: nil) , forCellReuseIdentifier: "eventTableViewCell")
        
        studentProfilePresenter.setViewDelegate(studentProfileViewDelegate: self)
        studentProfilePresenter.getUserName()
        studentProfilePresenter.getUserEmail()
        studentProfilePresenter.getUserGroupNumber()
        studentProfilePresenter.getUserPhoneNumber()
        
        studentProfilePresenter.showUserEvents()
    }
    
    func displayDataName(name: String) {
        nameLabel.text = name
        print(name)
    }
    
    func displayDataSurname(surname: String) {
        nameLabel.text = surname
    }
    
    func displayDataEmail(email: String) {
        emailLabel.text = email
    }
    
    func displayDataGroupNumber(groupNumber: String) {
        groupNumberLabel.text = groupNumber
    }
    
    func displayDataPhoneNumber(phoneNumber: String) {
        phoneNumberLabel.text = phoneNumber
    }
    
    func reloadData() {
         eventsTabeView.reloadData()
     }

    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension StudentProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentProfilePresenter.eventsUser.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell
        
        let eventsArray = studentProfilePresenter.eventsUser[indexPath.row]
        
        cell.setCellData(eventDateTime: eventsArray.eventDateTime!, eventName: eventsArray.eventName!, eventPlace: eventsArray.eventPlace!)
        return cell
        
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {

        let event = studentProfilePresenter.eventsUser[indexPath.row]
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "userDetailEventsViewController") as! UserDetailEventsViewController
        viewController.studentProfilePresenter = StudentProfilePresenter(userStudentService: UserStudentService())
        viewController.studentProfilePresenter.event = event
        navigationController?.pushViewController(viewController, animated: true)
    }

}
