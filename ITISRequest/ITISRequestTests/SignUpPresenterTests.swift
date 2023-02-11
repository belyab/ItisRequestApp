//
//  SignUpPresenterTests.swift
//  ITISRequestTests
//
//  Created by Эльмира Байгулова on 07.04.2022.
//

import Foundation
import XCTest
import Firebase
@testable import ITISRequest

class SignUpPresenterTests: XCTestCase {
    
    var view: SignUpViewController!
    var presenter: SignUpPresenter!
   
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = .init()
        
        presenter = SignUpPresenter(view: view)
        presenter.view = view
       
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        
        try super.tearDownWithError()
        
    }

    func testIsPasswordValidSuccess() throws {
        //Given
       let password = "Qawsed1!"
        
        //When
        let result = presenter.isPasswordValid(password)
        
        //Then
        XCTAssertEqual(result, true, "Пароль не соответсвует ожиданиям")
    }
    
    func testIsPasswordValidFail() throws {
        //Given
       let password = "Qawsed"
        
        //When
        let result = presenter.isPasswordValid(password)
        
        //Then
        XCTAssertEqual(result, false, "Пароль не соответсвует ожиданиям")
    }
    
    func testIsEmailValidSuccess() throws {
        //Given
       let email = "mail@google.com"
        
        //When
        let result = presenter.isEmailValid(email)
        
        //Then
        XCTAssertEqual(result, true, "Почта не соответсвует ожиданиям")
    }
    
    func testIsEmailValidFail() throws {
        //Given
       let email = "mail"
        
        //When
        let result = presenter.isEmailValid(email)
        
        //Then
        XCTAssertEqual(result, false, "Почта не соответсвует ожиданиям")
    }
    
    func testGetUserCollection() throws {
        //Given
        let dataBase = Firestore.firestore()
           
        //When
        var usersRef: CollectionReference {
            return dataBase.collection("users")
            
        }
           
        //Then
        XCTAssertNotNil(usersRef)
        
    }

}
