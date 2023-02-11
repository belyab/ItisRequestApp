//
//  AddEventPresenter.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 05.06.2022.
//

import UIKit

protocol AddEventProtocol {
    func isValidTextFieldWithNumber(textField: UITextField) -> Bool
    func addEvent(event: Event) -> Bool
    func validDateEvent(date: Date) -> Bool
}

class AddEventPresenter {
    
    // MARK: - Dependencies
    let userService: UserAdminService?
    
    // MARK: - Init
    init() {
        self.userService = UserAdminService()
    }
}

// MARK: - AddEventProtocol
extension AddEventPresenter: AddEventProtocol {
    
    func validDateEvent(date: Date) -> Bool {
        let nowDate = Date()
        return date > nowDate
    }
    
    func isValidTextFieldWithNumber(textField: UITextField) -> Bool {
        if (!textField.hasText) {
            return false
        } else {
            let scoreCount = Int(textField.text!)
            
            if (scoreCount == nil) {
                return false
            } else {
                if (scoreCount! < 0) {
                    return false
                }
                return true
            }
        }
    }
    
    func addEvent(event: Event) -> Bool {
        let result = userService!.addEvent(event: event)
        return result
    }
}
  
