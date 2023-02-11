//
//  CheckCodeForAdminViewController.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 03.06.2022.
//

import UIKit

protocol CheckCodeForAdminViewControllerProtocol: AnyObject {
    var code: String? { get }
    
    func isValidField() -> Bool
    func toProfile()
    func presentAlert(with message: String)
}

class CheckCodeForAdminViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var codeTextField: UITextField!
    
    // MARK: - Properties
    var code: String? {
        return codeTextField.text
    }
    var alertsFactory: AlertsFactory!
    var presenter: CheckCodePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Functions
    private func configure() {
        alertsFactory = AlertsFactoryImpl()
        presenter = CheckCodePresenter(with: self)
    }
    
    @IBAction func OkButtonPressed(_ sender: Any) {
        presenter.OkButtonPressed()
    }
    
}

// MARK: - CheckCodeForAdminViewControllerProtocol
extension CheckCodeForAdminViewController: CheckCodeForAdminViewControllerProtocol {
    
    func isValidField() -> Bool {
        if (!presenter.isEmptyCodeTextField(codeTextField: codeTextField)) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный код", message: "Вы не ввели код")
            present(alert, animated: true, completion: nil)
        } else {
            let codeText = codeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if (!presenter.isCodeValid(code: codeText)) {
                let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверный код", message: "Код должен состоять из 8 цифр")
                present(alert, animated: true, completion: nil)
            }
        }
        
        return true
    }
    
    func toProfile() {
        
    }
    
    func presentAlert(with message: String) {
        let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: message)
        present(alert, animated: true, completion: nil)
    }
}
