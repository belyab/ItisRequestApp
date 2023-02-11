import UIKit
import Firebase

protocol SignUpViewControllerProtocol: AnyObject {
    var surname: String? { get }
    var name: String? { get }
    var email: String? { get }
    var password: String? { get }
    var phoneNumber: String? { get }
    var groupNumber: String? { get }
    
    func isEmptyTextFields() -> String?
    func isValidAllProperties() -> String?
    func showAlert(title: String?, message: String?)
    func toSignIn()
    func toProfile()
}

class SignUpViewController: UIViewController{
    
    // MARK: - IBOutlets
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var groupNumberField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    //Dependencies
    var presenter: SignUpPresenter!
    
    var email: String? {
        return self.emailField.text
    }
    
    var password: String? {
        return self.passwordField.text
    }
    var surname: String? {
        return self.surnameField.text
    }
    var name: String? {
        return self.nameField.text
    }
    var phoneNumber: String? {
        return self.phoneNumberField.text
    }
    
    var groupNumber: String? {
        return self.groupNumberField.text
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePresenter()
    }
    
    // Private
    private func initializePresenter() {
        presenter = SignUpPresenter(view: self)
    }
    
    
    // MARK: - IBAction
    @IBAction func signInTapped(_ sender: Any) {
//        presenter.signInButtonTapped()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        presenter.signUpButtonTapped()
        
    }
    
}

// MARK: - SignUpViewControllerProtocol

extension SignUpViewController: SignUpViewControllerProtocol {
    
    func toSignIn() {
 
    }
    
    func toProfile() {
        let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarVC = tabBarStoryboard.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isEmptyTextFields() -> String? {
        if surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            groupNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(title: "Ошибка", message: "Заполните все поля")
            
        }
        return nil
    }
    
    func isValidAllProperties() -> String? {
        let cleanedName = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedSurname = surnameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPhoneNumber = phoneNumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if presenter.isNameValid(cleanedName) == false {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели имя  ")
        }
        
        if presenter.isSurnameValid(cleanedSurname) == false {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели фамилию")
        }
        
        if presenter.isEmailValid(cleanedEmail) == false {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели email")
        }
        
        if presenter.isPhoneNumberValid(cleanedPhoneNumber) == false {
            showAlert(title:"Ошибка", message: "Убедитесь, что вы правильно ввели номер телефона")
        }
        
        if presenter.isPasswordValid(cleanedPassword) == false {
            showAlert(title:"Ошибка", message: "Убедитесь, что в вашем пароле 8 символов,есть цифры и специальные символы")
        }
        return nil
    }
}


