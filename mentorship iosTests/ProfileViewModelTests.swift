//
//  ProfileViewModelTests.swift
//  Created on 10/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import XCTest
@testable import mentorship_ios

class ProfileViewModelTests: XCTestCase {
    let profileVM = ProfileViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveAndGetProfile() {
        //prepare sample data to use in saveProfile
        let sampleProfileData = ProfileModel.ProfileData(id: 100, email: "sampleTestEmail")
        
        //save sample data
        profileVM.saveProfile(profile: sampleProfileData)
        
        //get profile data
        let getProfileData = profileVM.getProfile()
        
        //Test if save and get function works properly
        //sample data saved and data received using get should be equal.
        XCTAssertEqual(sampleProfileData, getProfileData)
    }
    
    func testEditProfileDataReceived() {
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
}
