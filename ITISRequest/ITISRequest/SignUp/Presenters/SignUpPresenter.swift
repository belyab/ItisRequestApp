import Foundation
import Firebase

class SignUpPresenter {
    
    //Dependencies
    private let signUpModel: SignUpModel?
    weak var view: SignUpViewControllerProtocol?
    
    // MARK: - Init
    init(view: SignUpViewControllerProtocol) {
        self.view =  view
        self.signUpModel = SignUpModel()
    }
    
    func signUpButtonTapped() {
        
        //Валидация
        let errorEmpty = view?.isEmptyTextFields()
        let errorValid = view?.isValidAllProperties()
        
        if errorEmpty != nil {
            
            view?.showAlert(title: "Ошибка", message: errorEmpty!)
        }
        if errorValid != nil {
            view?.showAlert(title: "Ошибка", message: errorValid!)
        }
        
        guard
            let surname = view?.surname,
            let name = view?.name,
            let email = view?.email,
            let password = view?.password,
            let phoneNumber = view?.phoneNumber,
            let groupNumber = view?.groupNumber
        else { return }
        signUpModel?.signUp(surname: surname, name: name, email: email, password: password, phoneNumber: phoneNumber, groupNumber: groupNumber,  onSuccess: {
                self.view?.toProfile()
        }) { (error) in
            self.view?.showAlert(title: "Error", message: error!.localizedDescription)
        }
    }
    
    func signInButtonTapped() {
//        view?.toSignIn()
    }
    
    func isNameValid(_ name : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: name)
        
    }
    
    func isSurnameValid(_ surname : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: surname)
        
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordRegex.evaluate(with: password)
    }
    
    
    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@","^[0-9]{10}|[0-9]{11}$")
        return regex.evaluate(with: phoneNumber)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let regex =  NSPredicate(format: "SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        return regex.evaluate(with: email)
    }
}


