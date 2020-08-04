//
//  SignUpViewModelTests.swift
//  Created on 10/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class SignUpTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    
    // MARK: - Setup and Tear Down

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        super.tearDown()
    }
    
    // MARK: - Service Tests
    
    func testSignUpService() throws {
        // Login Service
        let signUpService: SignUpService = SignUpAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = SignUpModel.SignUpResponseData(message: "test data")
        let mockData = try JSONEncoder().encode(mockJSON)

        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Set sign up data
        let signUpData = SignUpModel.SignUpUploadData(name: "testName", username: "test", password: "password", email: "test", tncChecked: true, needMentoring: false, availableToMentor: false)
        
        // Make login request and test response data. Confirm password same as password.
        signUpService.signUp(availabilityPickerSelection: 0, signUpData: signUpData, confirmPassword: "password") { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testNonMatchingPasswordSignUp() {
        //set sign up data
        let signUpData = SignUpModel.SignUpUploadData(name: "testName", username: "test", password: "password", email: "test", tncChecked: true, needMentoring: false, availableToMentor: false)

        // Call signup. Use mocking for safety (completion should be called before network request made).
        SignUpAPI(urlSession: urlSession).signUp(availabilityPickerSelection: 0, signUpData: signUpData, confirmPassword: "password2") { response in
            // Test
            XCTAssertEqual(response.message, LocalizableStringConstants.passwordsDoNotMatch)
        }
    }
    
    // MARK: - ViewModel Tests
    
    func testSignUpButtonDisabledState() {
        let signupVM = SignUpViewModel()

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
    
    // MARK: - View Tests (Integration Tests)
    
    func testSignUpAction() throws {
        // Sign up service to inject in view for mock network calls
        let signUpService: SignUpService = SignUpAPI(urlSession: urlSession)

        // View model
        let signUpVM = SignUpViewModel()
        
        // Sign up View
        let signUpView = SignUp(signUpService: signUpService, signUpViewModel: signUpVM, isPresented: .constant(true))
        
        // Set mock json and data
        let mockJSON = SignUpModel.SignUpResponseData(message: "test data")
        let mockData = try JSONEncoder().encode(mockJSON)

        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // View Model should be in initial stage. Test
        XCTAssertEqual(signUpVM.signUpResponseData.message, "")
        
        // Perform sign up action
        signUpView.signUp()
        
        // expectation. used to test async code.
        let expectation = XCTestExpectation(description: "sign up")
        // View model should be updated. DispatchQueue used to wait for action to complete and then test.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(signUpVM.signUpResponseData.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
