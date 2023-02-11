import UIKit
import SafariServices
import MessageUI
import Firebase

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func feedbackButton(_ sender: Any) {
        let mailComposeViewController = configureMailComposer()
        
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true)
        } else {
            print("нет доступа")
        }
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            toSignIn()
            print("Sign out success")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func toSignIn() {
        
    }
    
    func configureMailComposer() -> MFMailComposeViewController {
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["itisRequest@gmail.com"])
        return composer
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

