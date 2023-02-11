//
//  SignInPresenter.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 09.03.2022.
//

import Foundation
import UIKit

class SignInPresenter {
    
    let signInModel: SignInModel
    weak var view: SignInViewControllerProtocol?
    
    init(with view: SignInViewControllerProtocol) {
        self.view = view
        self.signInModel = SignInModel()
        signInModel.delegate = self
    }
    
    func signInButtonTapped() {
        guard let error = view?.isValidFields() else { return }
        
        if (error) {
            guard let email = view?.email, let password = view?.password else { return }
            
            signInModel.signIn(with: email, password: password) { result
                in switch result {
                case .success(let user):
                    self.view?.toProfile(with: self.signInModel.getCurrentUserRole(userResult: user!))
                case .failure:
                    self.view?.presentUnexpectedErrorAlert()
                }}
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordTest.evaluate(with: password)
    }
    
    func isEmptyEmailTextField(emailTF: UITextField) -> Bool {
        return emailTF.hasText
    }
    
    func isEmptyPasswordTextField(passwordTF: UITextField) -> Bool {
        return passwordTF.hasText
    }
}

extension SignInPresenter: SignInModelDelegate {
    func didSignIn() {
        
    }
}
