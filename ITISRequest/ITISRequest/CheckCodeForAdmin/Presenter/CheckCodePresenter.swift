//
//  CheckCodePresenter.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 03.06.2022.
//

import UIKit

class CheckCodePresenter {
    
    // MARK: - Properties
    let checkCodeModel: CheckCodeModel
    let service: SignInForAdminService
    weak var view: CheckCodeForAdminViewControllerProtocol?
    
    init(with view: CheckCodeForAdminViewControllerProtocol) {
        self.service = SignInForAdminService()
        self.view = view
        self.checkCodeModel = CheckCodeModel()
        checkCodeModel.delegate = self
    }
    
    // MARK: - Functions
    func OkButtonPressed() {
        guard let error = view?.isValidField() else {
            return
        }
        
        if (error) {
            guard let code = view?.code else { return }
            
            let result = checkCodeModel.check(with: code)
            
            if (result) {
                self.view?.toProfile()
            } else {
                self.view?.presentAlert(with: "Вы не являетесь администратором")
            }
        }
    }
    
    func isEmptyCodeTextField(codeTextField: UITextField) -> Bool {
        return codeTextField.hasText
    }
    
    func isCodeValid(code: String) -> Bool {
        let codeRegex = "\\A[0-9]{8}\\z"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        
        return codeTest.evaluate(with: code)
    }
}

// MARK: - CheckCodeModelDelegate
extension CheckCodePresenter: CheckCodeModelDelegate {
    func checkCode(code: String) -> Bool {
        return false
    }
}
