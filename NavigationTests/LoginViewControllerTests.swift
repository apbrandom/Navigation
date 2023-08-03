//
//  LoginViewControllerTests.swift
//  NavigationTests
//
//  Created by Vadim Vinogradov on 03.08.2023.
//

import XCTest
@testable import Navigation
import FirebaseAuth

class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    var mockDelegate: MockLoginInspector!
    var userService: UserService!
    
    override func setUp() {
        super.setUp()
        userService = TestUserService()
        mockDelegate = MockLoginInspector()
        sut = LoginViewController(userService: userService, loginInspector: mockDelegate)
    }
    
    override func tearDown() {
        sut = nil
        userService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testSignInButtonTapped() {
        sut.signInButtonTapped()
        XCTAssertTrue(mockDelegate.checkCredentialsCalled, "checkCredentials was not called")
    }
    
}

class MockLoginInspector: LoginViewControllerDelegate {
    var checkCredentialsCalled = false
    var signUpCalled = false
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        checkCredentialsCalled = true
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        signUpCalled = true
    }
}


