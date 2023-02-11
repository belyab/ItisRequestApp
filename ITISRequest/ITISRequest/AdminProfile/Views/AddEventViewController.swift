//
//  AddEventViewController.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 04.06.2022.
//

import UIKit

class AddEventViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var dateEventTextField: UITextField!
    @IBOutlet weak var placeEventTextField: UITextField!
    @IBOutlet weak var scoreCountEventTextField: UITextField!
    @IBOutlet weak var typeEventTextField: UITextField!
    @IBOutlet weak var noteEventTextField: UITextField!
    @IBOutlet weak var descriptionEventTextField: UITextField!
    @IBOutlet weak var nameEventTextField: UITextField!
    @IBOutlet weak var maxMembersCountTextField: UITextField!
    
    // MARK: - Dependencies
    let datePicker = UIDatePicker()
    var addEventPresenter = AddEventPresenter()
    var alertsFactory = AlertsFactoryImpl()
    var newEvent = Event()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateEventTextField()
        configureTextFieldsTargets()
        
    }
    
    // MARK: - Action
    @IBAction func okButtonPressed(_ sender: Any) {
        if (addEventPresenter.addEvent(event: newEvent)) {
            toProfile()
        } else {
            let alert = alertsFactory.getAlert(by: .unexpectedErrorAlert, title: "Непредвиденная ошибка", message: "Пожалуйста, повторите позже")
            present(alert, animated: true, completion: nil)
        }
    }
    
    func toProfile() {
        //переход в профиль
    }
    
    // MARK: - Functions
    private func configureTextFieldsTargets() {
        scoreCountEventTextField.addTarget(self, action: #selector(scoreCountEventTextFieldDidEnd), for: .editingDidEnd)
        placeEventTextField.addTarget(self, action: #selector(placeEventTextFieldDidEnd), for: .editingDidEnd)
        typeEventTextField.addTarget(self, action: #selector(typeEventTextFieldDidEnd), for: .editingDidEnd)
        noteEventTextField.addTarget(self, action: #selector(noteEventTextFieldDidEnd), for: .editingDidEnd)
        descriptionEventTextField.addTarget(self, action: #selector(descriptionEventTextFieldDidEnd), for: .editingDidEnd)
        nameEventTextField.addTarget(self, action: #selector(nameEventTextFieldDidEnd), for: .editingDidEnd)
        maxMembersCountTextField.addTarget(self, action: #selector(maxMemberCountTextFieldDidEnd), for: .editingChanged)
    }
    
    @objc func scoreCountEventTextFieldDidEnd(textField: UITextField) {
        let result = addEventPresenter.isValidTextFieldWithNumber(textField: textField)
        
        if (!result) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверное количество баллов", message: "Убедитесь, что поле не пустое и баллы положительные")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventScoreCount = Int(textField.text!)
            
            
        }
    }
    
    @objc func maxMemberCountTextFieldDidEnd(textField: UITextField) {
        let result = addEventPresenter.isValidTextFieldWithNumber(textField: textField)
        
        if (!result) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Неверное количество участников", message: "Убедитесь, что поле не пустое и значение положительное")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventMaxMemberCount = Int(textField.text!)
        }
    }
    
    @objc func placeEventTextFieldDidEnd(textField: UITextField) {
        if (!textField.hasText) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Убедитесь, что поле не пустое")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventPlace = textField.text!
        }
    }
    
    @objc func typeEventTextFieldDidEnd(textField: UITextField) {
        if (!textField.hasText) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Убедитесь, что поле не пустое")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventType = textField.text!
        }
    }
    
    @objc func noteEventTextFieldDidEnd(textField: UITextField) {
        if (!textField.hasText) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Убедитесь, что поле не пустое")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventNote = textField.text!
        }
    }
    
    @objc func descriptionEventTextFieldDidEnd(textField: UITextField) {
        if (!textField.hasText) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Убедитесь, что поле не пустое")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventDescription = textField.text!
        }
    }
    
    @objc func nameEventTextFieldDidEnd(textField: UITextField) {
        if (!textField.hasText) {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Убедитесь, что поле не пустое")
            present(alert, animated: true, completion: nil)
        } else {
            newEvent.eventName = textField.text!
        }
    }
    
    
    private func configureDateEventTextField() {
        dateEventTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        
        dateEventTextField.inputAccessoryView = toolBar
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func doneAction() {
        view.endEditing(true)
        getDateFromPicker()
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
        getDateFromPicker()
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        if (addEventPresenter.validDateEvent(date: datePicker.date)) {
            dateEventTextField.text = formatter.string(from: datePicker.date)
            newEvent.eventDateTime = formatter.date(from: dateEventTextField.text!)
        } else {
            let alert = alertsFactory.getAlert(by: .okAlert, title: "Ошибка", message: "Дата мероприятия не может быть раньше текущей")
            present(alert, animated: true, completion: nil)
        }
    }
}
