//
//  SignUpViewModelTests.swift
//  Created on 10/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class SignUpViewModelTests: XCTestCase {
    //init sign up view model
    let signupVM = SignUpViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNonMatchingPasswordSignUp() {
        //set password and confirm password
        signupVM.signUpData.password = "TestPassword"
        signupVM.confirmPassword = "TestPassword1"
        
        //call signup
        signupVM.signUp()
        
        //test
        XCTAssertEqual(signupVM.signUpResponseData.message, "Passwords do not match")
    }
    
    func testSignUpButtonDisabledState() {
        // MARK: - 1. When fields empty. Disabled state should be true.
        
        //set disabled state. Currently, data is empty.
        var signUpDisabledState = signupVM.signupDisabled
        
        //Test
        XCTAssertEqual(signUpDisabledState, true)
        
        // MARK: - 2. When fields filled. Disabled state should be false.

        //set sign up data and confirm password used by signupDisbaled property
        signupVM.signUpData = SignUpModel.SignUpUploadData(name: "testName", username: "test", password: "password", email: "test", tncChecked: true, needMentoring: false, availableToMentor: false)
        //confirm password different than normal password. However, this is allowed.
        signupVM.confirmPassword = "password-2"
        
        signUpDisabledState = signupVM.signupDisabled
        
        //Test
        XCTAssertEqual(signUpDisabledState, false)
        
        // MARK: - 3. When 'password' and 'confirm password' both empty (equal) and other fields filled. Disabled state should be true.
        signupVM.signUpData = SignUpModel.SignUpUploadData(name: "testName", username: "test", password: "", email: "test", tncChecked: true, needMentoring: false, availableToMentor: false)
        signupVM.confirmPassword = ""
        
        signUpDisabledState = signupVM.signupDisabled
        
        // empty passwords not allowed (though equal). Hence, button should be disabled.
        XCTAssertEqual(signUpDisabledState, true)
    }
}
