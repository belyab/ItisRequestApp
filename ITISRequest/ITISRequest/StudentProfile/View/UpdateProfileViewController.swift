import UIKit

protocol UpdateProfileViewControllerProtocol: AnyObject {
    func showAlert(title: String?, message: String?)
}

class UpdateProfileViewController: UIViewController, UpdateProfilePresenterDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private var nameTextField: DesignableTextField!
    @IBOutlet private var phoneNumberTextField: DesignableTextField!
    @IBOutlet private var groupNumberTextField: DesignableTextField!
    @IBOutlet private var surnameTextField: DesignableTextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //Dependencies
    private let updateProfilePresenter = UpdateProfilePresenter(userStudentService: UserStudentService())
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProfilePresenter.setViewDelegate(updateProfilePresenterDelegate: self)
        updateProfilePresenter.getUserName()
        updateProfilePresenter.getUserSurname()
        updateProfilePresenter.getUserGroupNumber()
        updateProfilePresenter.getUserPhoneNumber()
    }
    
    // MARK: - IBActions
    @IBAction func completeButton(_ sender: Any) {
        
        let cleanedName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if updateProfilePresenter.isNameValid(cleanedName) == true {
            updateProfilePresenter.updateDataName(name: nameTextField.text!)
        } else {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели имя  ")
        }
        
        let cleanedSurname = surnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if updateProfilePresenter.isNameValid(cleanedSurname) == true {
            updateProfilePresenter.updateDataSurname(surname: surnameTextField.text!)
        } else {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели фамилию")
        }
        
        let cleanedPhoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if updateProfilePresenter.isPhoneNumberValid(cleanedPhoneNumber) == true {
            updateProfilePresenter.updateDataPhoneNumber(phoneNumber: phoneNumberTextField.text!)
        } else {
            showAlert(title:"Ошибка", message: "Убедитесь, что правильно ввели фамилию")
        }
        
        updateProfilePresenter.updateDataGroupNumber(groupNumber: groupNumberTextField.text!)
        
        // TODO: переход на страницу профиля
        
    }
    
    // TODO: переход на страницу профиля
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
    func displayDataName(name: String) {
        nameTextField.text = name
    }
    
    func displayDataSurname(surname: String) {
        surnameTextField.text = surname
    }
    
    func displayDataGroupNumber(groupNumber: String) {
        groupNumberTextField.text = groupNumber
    }
    
    func displayDataPhoneNumber(phoneNumber: String) {
        phoneNumberTextField.text = phoneNumber
    }
}

// MARK: - UpdateProfileViewControllerProtocol

extension UpdateProfileViewController: UpdateProfileViewControllerProtocol {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
