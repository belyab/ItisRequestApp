//
//  AdminProfileViewController.swift
//  ITISRequest
//
//  Created by Милана Махсотова on 03.06.2022.
//

import UIKit

class AdminProfileViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    // MARK: - Dependencies
    let adminProfilePresenter = AdminProfilePresenter()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Functions
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil) , forCellReuseIdentifier: "eventTableViewCell")

        adminProfilePresenter.setAdminProfileViewDelegate(adminProfileViewDelegate: self)
        adminProfilePresenter.getUserData()
        adminProfilePresenter.showAdminEvents()
    }

}

 //MARK: - UITableViewDelegate & UITableViewDataSource
extension AdminProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminProfilePresenter.eventsUser.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as! EventTableViewCell

        let eventsArray = adminProfilePresenter.eventsUser[indexPath.row]

        cell.setCellData(eventDateTime: eventsArray.eventDateTime!, eventName: eventsArray.eventName!, eventPlace: eventsArray.eventPlace!)
        return cell
    }
}

// MARK: - AdminProfileViewDelegate
extension AdminProfileViewController: AdminProfileViewDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func displayDataName(name: String) {
        nameLabel.text = name
    }
    
    func displayDataGroupNumber(groupNumber: String) {
        groupLabel.text = groupNumber
    }
    
    func displayDataEmail(email: String) {
        emailLabel.text = email
    }
    
    func displayDataPhoneNumber(phoneNumber: String) {
        telephoneNumberLabel.text = phoneNumber
    }
    
    func displayDataSurname(surname: String) {
        //no display surname
    }
}
