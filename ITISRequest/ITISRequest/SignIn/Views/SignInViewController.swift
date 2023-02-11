//
//  SignInViewController.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 09.03.2022.
//

import UIKit
import Firebase

protocol SignInViewControllerProtocol: AnyObject {
    var email: String? { get }
    var password: String? { get }
    
    func isValidFields() -> Bool
    func toProfile(with roleUser: String)
    func presentUnexpectedErrorAlert()
}

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Dependencies
    var presenter: SignInPresenter!
    var alertsFactory: AlertsFactory!
    var email: String? {
        return emailTextField.text
    }
    var password: String? {
        return passwordTextField.text
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Functions
    func configure() {
        presenter = SignInPresenter(with: self)
        alertsFactory = AlertsFactoryImpl()
        
    }
    
    // MARK: - Button Actions
    @IBAction func signInButtonPressed(_ sender: Any) {
        presenter.signInButtonTapped()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
    }
    
}

// MARK: - SignInViewControllerProtocol
extension SignInViewController: SignInViewControllerProtocol {
    
    func toProfile(with roleUser: String) {
        if roleUser == "isAdmin" {
            let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
            let tabBarVC = tabBarStoryboard.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        } else {
            let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
            let tabBarVC = tabBarStoryboard.instantiateViewController(withIdentifier: "tabBarSecondVC") as! UITabBarController
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        }
    }
    
    func isValidFields() -> Bool {
        
        if (!presenter.isEmptyEmailTextField(emailTF: emailTextField)) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный email", message: "Вы не ввели свой email")
            present(alert, animated: true, completion: nil)
        } else {
            if (!presenter.isEmptyPasswordTextField(passwordTF: passwordTextField)) {
                let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный пароль", message: "Вы не ввели свой пароль")
                present(alert, animated: true, completion: nil)
            } else {
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                print(password)
                
                if (!presenter.isEmailValid(email: email)) {
                    let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный email", message: "Убедитесь, что ваш email правильный")
                    present(alert, animated: true, completion: nil)
                } else {
                    if (!presenter.isPasswordValid(password: password)) {
                        let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный пароль", message: "Убедитесь, что ваш пароль правильный")
                        present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        return true
    }
    
    func presentUnexpectedErrorAlert() {
        let alert = alertsFactory.getAlert(by: .unexpectedErrorAlert, title: nil, message: nil)
        present(alert, animated: true, completion: nil)
        
    }
}
