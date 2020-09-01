//
//  ProfileViewModelTests.swift
//  Created on 10/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class ProfileTests: XCTestCase {
    // sample profile data
    let sampleProfileData = ProfileModel.ProfileData(id: 100, email: "sampleTestEmail")
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
    
    func testGetProfileService() throws {
        // Profile Service
        let profileService: ProfileService = ProfileAPI(urlSession: urlSession)
        
        // Set mock data
        let mockData = try JSONEncoder().encode(sampleProfileData)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make request to get profile
        profileService.getProfile { resp in
            XCTAssertEqual(resp, self.sampleProfileData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testUpdateProfileService() throws {
        // Profile Service
        let profileService: ProfileService = ProfileAPI(urlSession: urlSession)
        
        // Set mock json and data
        let mockJSON = ProfileModel.UpdateProfileResponseData(success: true, message: "response")
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make request to get profile
        profileService.updateProfile(updateProfileData: self.sampleProfileData) { response in
            XCTAssertEqual(response.success, true)
            XCTAssertEqual(response.message, mockJSON.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - ViewModel Tests
    
    func testSaveAndGetProfile() {
        let profileVM = ProfileViewModel()

        //save sample data
        profileVM.saveProfile(profile: sampleProfileData)
        
        //get profile data
        let getProfileData = profileVM.getProfile()
        
        //Test if save and get function works properly
        //sample data saved and data received using get should be equal.
        XCTAssertEqual(sampleProfileData, getProfileData)
    }
    
    func testEditProfileDataReceived() {
        let profileVM = ProfileViewModel()

        //prepare sample data
        let sampleData = ProfileModel.ProfileData(id: 100, name: nil, username: "username", email: "test@abc.com")
        
        //save sample data to profile
        //reason: getEditProfileData uses getProfile function to get stored data. Hence it will return this sample data now.
        profileVM.saveProfile(profile: sampleData)
        
        // get edit profile data
        let editProfileData = profileVM.getEditProfileData()
        
        //id and email should be unchanged
        XCTAssertEqual(editProfileData.id, sampleData.id)
        XCTAssertEqual(editProfileData.email, sampleData.email)
        
        //name should be empty string (""). nil values are converted to allow for safe force unwrapping
        XCTAssertEqual(editProfileData.name, "")
        
        //username should be nil. Username is made nil since it can't be updated. Otherwise, the backend call fails.
        XCTAssertEqual(editProfileData.username, nil)
    }
    
    func testSaveUpdatedProfile() {
        let profileVM = ProfileViewModel()
        
        //prepare sample data
        let sampleData = ProfileModel.ProfileData(id: 0, name: "name", username: "", email: "")
        
        //save sample data to profile
        //reason: getEditProfileData uses getProfile function to get stored data. Hence it will return this sample data now.
        profileVM.saveProfile(profile: sampleData)
        
        // Get this current profile data and test
        XCTAssertEqual(profileVM.getProfile().name, "name")
        
        // get edit profile data
        var editProfileData = profileVM.getEditProfileData()
        
        // configure edit profile data
        editProfileData.name = "newName"
        
        // Save updated profile
        profileVM.saveUpdatedProfile(updatedProfileData: editProfileData)
        
        // Test the profile has been updated
        XCTAssertEqual(profileVM.getProfile().name, "newName")
    }
    
    // MARK: View Tests (Integration Tests)
    
    func testUpdateProfileAction() throws {
        // Profile Service
        let profileService: ProfileService = ProfileAPI(urlSession: urlSession)
        
        // View Model
        let profileVM = ProfileViewModel()
        
        // Profile Editor View
        let profileEditor = ProfileEditor(profileService: profileService, profileViewModel: profileVM)
        
        // Set mock json and data
        let mockJSON = ProfileModel.UpdateProfileResponseData(success: true, message: "response")
        let mockData = try JSONEncoder().encode(mockJSON)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }
        
        // Call Update Profile
        profileEditor.updateProfile()
        
        // expectation. used to test async code.
        let expectation = XCTestExpectation(description: "login")
        // Wait and then test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Profile view model should be updated with response values.
            XCTAssertEqual(profileVM.updateProfileResponseData.message, mockJSON.message)
            // inActivity should be false
            XCTAssertEqual(profileVM.inActivity, false)
            // Alert should be shown
            XCTAssertEqual(profileVM.showAlert, true)
            // Test for success.
            XCTAssertEqual(profileVM.updateProfileResponseData.success, true)
            // Alert title should be success
            XCTAssertEqual(profileVM.alertTitle, LocalizableStringConstants.success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
