//
//  SignInPresenterUnitTests.swift
//  ITISRequestTests
//
//  Created by Милана Махсотова on 05.04.2022.
//

import XCTest
@testable import ITISRequest

class SignInPresenterUnitTests: XCTestCase {

    var presenter: SignInPresenter!
    var view: SignInViewControllerProtocol!
    
    
    override func setUpWithError() throws {
        view = SignInViewController()
        presenter = SignInPresenter(with: view)
    }

    override func tearDownWithError() throws {
        presenter = nil
        view = nil
    }

    func testPresenterCorrectWithEmptyEmail() throws {
        //Given
        let emailTextField = UITextField()
        let expectedResult = false
        var validateResult: Bool
        
        //When
        validateResult = presenter.isEmptyEmailTextField(emailTF: emailTextField)
        
        //Then
        XCTAssertEqual(expectedResult, validateResult)
    }
    
    func testPresenterCorrectWithEmptyPassword() throws {
        //Given
        let passwordTextField = UITextField()
        let expectedResult = false
        var validateResult:  Bool
        
        //When
        validateResult = presenter.isEmptyPasswordTextField(passwordTF: passwordTextField)
        
        //Then
        XCTAssertEqual(expectedResult, validateResult)
        
    }
    
    func testPresenterCorrectLengthWithEmail() throws {
        //Given
        let emailTextField = UITextField()
        emailTextField.text = "test@.ru"
        let expectedResult = false
        var validateResult: Bool
        
        //When
        validateResult = presenter.isEmailValid(email: emailTextField.text!)
        
        //Then
        XCTAssertEqual(expectedResult, validateResult)
        
    }
    
    func testPresenterCorrectLengthWithPassword() throws {
        //Given
        var passwordTextField = UITextField()
        passwordTextField.text = "test"
        let expectedResult = false
        var validateResult: Bool
        
        //When
        validateResult = presenter.isPasswordValid(password: passwordTextField.text!)
        
        //Then
        XCTAssertEqual(expectedResult, validateResult)
        
    }
    
    func testPresenterCorrectValueWithPassword() throws {
        //Given
        var passwordTextField = UITextField()
        passwordTextField.text = "test1234"
        let expectedResult = false
        var validateResult: Bool
        
        //When
        validateResult = presenter.isPasswordValid(password: passwordTextField.text!)
        
        //Then
        XCTAssertEqual(expectedResult, validateResult)
    }
}
