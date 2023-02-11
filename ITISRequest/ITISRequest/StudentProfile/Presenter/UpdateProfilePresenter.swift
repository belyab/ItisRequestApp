import Foundation
import UIKit

protocol UpdateProfilePresenterDelegate: NSObjectProtocol{
    func displayDataName(name: String)
    func displayDataSurname(surname: String)
    func displayDataGroupNumber(groupNumber: String)
    func displayDataPhoneNumber(phoneNumber: String)
}

class UpdateProfilePresenter {
    
    //Dependencies
    private let userStudentService: UserStudentService
    weak private var updateProfilePresenterDelegate: UpdateProfilePresenterDelegate?
    
    
    // MARK: - Init
    init(userStudentService:UserStudentService){
        self.userStudentService = userStudentService
    }
    
    func setViewDelegate(updateProfilePresenterDelegate:UpdateProfilePresenterDelegate?){
        self.updateProfilePresenterDelegate = updateProfilePresenterDelegate
    }
    
    
    func updateDataName(name: String) {
        userStudentService.updateName(name: name)
    }
    
    func updateDataSurname(surname: String) {
        userStudentService.updateSurname(surname: surname)
    }
    
    func updateDataGroupNumber(groupNumber: String) {
        userStudentService.updateGroupNumber(groupNumber: groupNumber)
    }
    
    func updateDataPhoneNumber(phoneNumber: String) {
        userStudentService.updatePhoneNumber(phoneNumber: phoneNumber)
    }
    
    
    func getUserName() {
        userStudentService.getDataName {[self] name in
            self.updateProfilePresenterDelegate?.displayDataName(name: name)
            print(name)
        }
    }
    
    func getUserSurname() {
        userStudentService.getDataSurname {[self] surname in
            self.updateProfilePresenterDelegate?.displayDataSurname(surname: surname)
        }
    }
    
    func getUserGroupNumber() {
        userStudentService.getGroupNumber {[self] groupNumber in
            self.updateProfilePresenterDelegate?.displayDataGroupNumber(groupNumber: groupNumber)
        }
    }
    
    func getUserPhoneNumber() {
        userStudentService.getPhoneNumber {[self] phoneNumber in
            self.updateProfilePresenterDelegate?.displayDataPhoneNumber(phoneNumber: phoneNumber)
        }
    }
    
    func isNameValid(_ name : String) -> Bool {
        let nameRegex = NSPredicate(format: "SELF MATCHES %@", "^([А-Я]{1}[а-яё]{1,23}|[A-Z]{1}[a-z]{1,23})$")
        return nameRegex.evaluate(with: name)
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
