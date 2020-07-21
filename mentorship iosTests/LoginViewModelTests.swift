//
//  LoginViewModelTests.swift
//  Created on 10/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class LoginViewModelTests: XCTestCase {
    //init sign up view model
    let loginVM = LoginViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginButtonDisabledState() {
        // MARK: - 1. When fields empty. Disabled state should be true.
        
        //set disabled state. Currently, data is empty.
        var loginDisabledState = loginVM.loginDisabled
        
        //Test
        XCTAssertEqual(loginDisabledState, true)
        
        // MARK: - 2. When one filed filled and one empty. Disabled state should be true
        loginVM.loginData = LoginModel.LoginUploadData(username: "username", password: "")
        
        loginDisabledState = loginVM.loginDisabled

        //Test
        XCTAssertEqual(loginDisabledState, true)
        
        // MARK: - 3. When all fields filled. Disabled state should be false.
        loginVM.loginData = LoginModel.LoginUploadData(username: "username", password: "password")
        
        loginDisabledState = loginVM.loginDisabled
        
        //Test
        XCTAssertEqual(loginDisabledState, false)
    }

}
