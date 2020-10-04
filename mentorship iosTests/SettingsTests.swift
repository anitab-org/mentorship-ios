//
//  SettingsTests.swift
//  Created on 26/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class SettingsTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    
    // MARK: - Setup and Tear Down

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        // set temp keychain token
        // api calls require a token, otherwise tests fail
        try KeychainManager.setToken(username: "", tokenString: "")
    }

    override func tearDownWithError() throws {
        urlSession = nil
        try KeychainManager.deleteToken()
        super.tearDown()
    }
    
    // MARK: - Service Tests
    
    func testDeleteAccountService() throws {
        let settingsService: SettingsService = SettingsAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = SettingsModel.DeleteAccountResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        settingsService.deleteAccount { resp in
            XCTAssertEqual(resp.message, mockJSON.message)
            XCTAssertEqual(resp.success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testChangePasswordService() throws {
        let settingsService: SettingsService = SettingsAPI(urlSession: urlSession)

        // Set mock json and data
        let mockJSON = ChangePasswordModel.ChangePasswordResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // MARK: Confirm password not equal to new password.
        let expectation1 = XCTestExpectation(description: "response1")
        settingsService.changePassword(
            changePasswordData: ChangePasswordModel.ChangePasswordUploadData(currentPassword: "test", newPassword: "abcd"),
            confirmPassword: "ab") { resp in
                XCTAssertEqual(resp.message, LocalizableStringConstants.passwordsDoNotMatch)
                XCTAssertEqual(resp.success, false)
                expectation1.fulfill()
        }
        
        // MARK: Confirm password not equal to new password.
        let expectation2 = XCTestExpectation(description: "response2")
        settingsService.changePassword(
            changePasswordData: ChangePasswordModel.ChangePasswordUploadData(currentPassword: "test", newPassword: "abcd"),
            confirmPassword: "abcd") { resp in
                XCTAssertEqual(resp.message, mockJSON.message)
                expectation2.fulfill()
        }
        
        wait(for: [expectation1, expectation2], timeout: 1)
    }
     
    // MARK: - View Tests (Integration Tests)
    
    func testChangePasswordAction() throws {
        // Service
        let settingsService: SettingsService = SettingsAPI(urlSession: urlSession)
        // View Model
        let changePasswordVM = ChangePasswordViewModel()
        // View
        let changePasswordView = ChangePassword(settingsService: settingsService, changePasswordViewModel: changePasswordVM)
        
        // Set mock json and data
        let mockJSON = ChangePasswordModel.ChangePasswordResponseData(message: "test", success: true)
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data form mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Configure view model
        changePasswordVM.changePasswordData = ChangePasswordModel.ChangePasswordUploadData(currentPassword: "old", newPassword: "new")
        changePasswordVM.confirmPassword = "new"
        
        // Call change password action
        changePasswordView.changePassword()
        
        // Expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "change password")
        
        // Wait using GCD and then test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // View model should be updated
            XCTAssertEqual(changePasswordVM.changePasswordResponseData.message, mockJSON.message)
            XCTAssertEqual(changePasswordVM.inActivity, false)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testChangePasswordReset() {
        // View Model
        let changePasswordVM = ChangePasswordViewModel()

        // Set mock data
        changePasswordVM.changePasswordData = ChangePasswordModel.ChangePasswordUploadData(currentPassword: "old", newPassword: "new")
        changePasswordVM.confirmPassword = "new"
        changePasswordVM.changePasswordResponseData = ChangePasswordModel.ChangePasswordResponseData(message: "test", success: true)

        // reset data of View Model
        changePasswordVM.resetData()

        // test
        XCTAssertEqual("", changePasswordVM.changePasswordData.currentPassword)
        XCTAssertEqual("", changePasswordVM.changePasswordData.newPassword)
        XCTAssertEqual("", changePasswordVM.confirmPassword)
        XCTAssertEqual("", changePasswordVM.changePasswordResponseData.message)
        XCTAssertEqual(false, changePasswordVM.changePasswordResponseData.success)
    }
}
