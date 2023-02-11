import UIKit
import Firebase
import SDWebImage

protocol EventsViewProtocol: AnyObject {
    func reloadData()
    func showAlert(title: String?, message: String?)
}

class EventsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var eventsTableView: UITableView!
    
    //Dependencies
    var eventPresenter : EventPresenter!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePresenter()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil) , forCellReuseIdentifier: "eventTableViewCell")
        
        eventPresenter.showEvents()
    }
    
    func initializePresenter() {
        eventPresenter = EventPresenter(view: self)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventPresenter.eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell
        
        let eventsArray = eventPresenter.eventsArray[indexPath.row]
        
        cell.setCellData(eventDateTime: eventsArray.eventDateTime!, eventName: eventsArray.eventName!, eventPlace: eventsArray.eventPlace!)
        return cell
        
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let event = eventPresenter.eventsArray[indexPath.row]
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailEventViewController") as! DetailEventViewController
        viewController.eventsPresenter = EventPresenter()
        viewController.eventsPresenter.event = event
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

// MARK: - EventsViewProtocol

extension EventsViewController: EventsViewProtocol {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        eventsTableView.reloadData()
    }
}
