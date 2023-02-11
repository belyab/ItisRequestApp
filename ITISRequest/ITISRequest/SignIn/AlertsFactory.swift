//
//  AlertFactory.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 15.03.2022.
//

import Foundation
import UIKit

enum Alerts {
    case okAlert
    case cancelAlert
    case unexpectedErrorAlert
}

protocol AlertsFactory: AnyObject {
    func getAlert(by type: Alerts, title: String?, message: String?) -> UIViewController
}

class AlertsFactoryImpl: AlertsFactory {
    func getAlert(by type: Alerts, title: String?, message: String?) -> UIViewController {
        switch type {
        case .okAlert:
            return configureOkAlert(title: title, message: message)
        case .cancelAlert:
            return configureCancelAlert(title: title, message: message)
        case .unexpectedErrorAlert:
            return configureUnexpectedErrorAlert(title: nil, message: nil)
        }
    }
    
    // MARK: - Private Functions
    private func configureOkAlert(title: String?, message: String?) -> UIViewController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        return alertController
    }
    
    private func configureCancelAlert(title: String?, message: String?) -> UIViewController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(action)
        
        return alertController
    }
    
    private func configureUnexpectedErrorAlert(title: String?, message: String?) -> UIViewController {
        
        let alertController = UIAlertController(title: nil, message: "Возникла непредвиденная ошибка. Повторите пожалуйста позже", preferredStyle: .alert)
        let action = UIAlertAction(title: "Error", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        return alertController
    }
}
