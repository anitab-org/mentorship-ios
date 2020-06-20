//
//  ProfileModel.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI
import Combine

final class ProfileModel: ObservableObject {

    // MARK: - Variables
    let profileData = ProfileData(
        id: 0,
        name: "",
        username: "",
        email: "",
        bio: "",
        location: "",
        occupation: "",
        organization: "",
        slackUsername: "",
        skills: "",
        interests: "",
        needMentoring: false,
        availableToMentor: false
    )
    @Published var updateProfileResponseData = UpdateProfileResponseData(message: "")
    @Published var inActivity = false
    @Published var showAlert = false
    var alertTitle = LocalizedStringKey("")
    private var cancellable: AnyCancellable?
    

    // MARK: - Functions
    
    //saves profile in user defaults
    func saveProfile(profile: ProfileData) {
        guard let profileData = try? JSONEncoder().encode(profile) else {
            return
        }
        UserDefaults.standard.set(profileData, forKey: UserDefaultsConstants.profile)
    }

    //gets profile object from user defaults
    func getProfile() -> ProfileData {
        guard let profileData = UserDefaults.standard.data(forKey: UserDefaultsConstants.profile) else {
            return self.profileData
        }
        guard let profile = try? JSONDecoder().decode(ProfileData.self, from: profileData) else {
            return self.profileData
        }
        return profile
    }
    
    //returns profile data with some processing to make it suitable for use in profile editor
    func getEditProfileData() -> ProfileData {
        var editProfileData = getProfile()
        
        //Replace nil values with empty values.
        //Done to enable force-unwrap of binding, to be used in edit text field in profile editor.
        //Optional bindings are not allowed.
        if editProfileData.name == nil { editProfileData.name = "" }
        if editProfileData.bio == nil { editProfileData.bio = "" }
        if editProfileData.location == nil { editProfileData.location = "" }
        if editProfileData.occupation == nil { editProfileData.occupation = "" }
        if editProfileData.organization == nil { editProfileData.organization = "" }
        if editProfileData.slackUsername == nil { editProfileData.slackUsername = "" }
        if editProfileData.skills == nil { editProfileData.skills = "" }
        if editProfileData.interests == nil { editProfileData.interests = "" }
        if editProfileData.needMentoring == nil { editProfileData.needMentoring = false }
        if editProfileData.availableToMentor == nil { editProfileData.availableToMentor = false }
        
        //Set username to nil.
        //Reason: username can't be updated.
        //Sending nil username to server keeps it unchanged.
        editProfileData.username = nil

        return editProfileData
    }
    
    //makes api call to update profile
    func updateProfile(updateProfileData: ProfileData) {
        //get auth token
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        
        //encoded upload data
        guard let uploadData = try? JSONEncoder().encode(updateProfileData) else {
            return
        }
        
        self.inActivity = true
        
        //func to save updated profile in user defaults
        func saveUpdatedProfile() {
            let currentProfileData = getProfile()
            var newProfileData = updateProfileData
            newProfileData.username = currentProfileData.username
            self.saveProfile(profile: newProfileData)
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.profile, httpMethod: "PUT", uploadData: uploadData, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.updateProfileResponseData) }
            .sink {
                self.updateProfileResponseData = $0
                self.inActivity = false
                //Show alert after call completes
                self.showAlert = true
                if NetworkManager.responseCode == 200 {
                    self.alertTitle = LocalizableStringConstants.success
                    //update profile data in user defaults on success
                    saveUpdatedProfile()
                } else {
                    self.alertTitle = LocalizableStringConstants.failure
                }
        }
    }

    // MARK: - Structures
    struct ProfileData: Codable, ProfileProperties {
        let id: Int
        var name: String?
        var username: String?
        let email: String?
        var bio: String?
        var location: String?
        var occupation: String?
        var organization: String?
        var slackUsername: String?
        var skills: String?
        var interests: String?
        var needMentoring: Bool?
        var availableToMentor: Bool?

        enum CodingKeys: String, CodingKey {
            case id, name, username, email, bio, location, occupation, organization, skills, interests
            case slackUsername = "slack_username"
            case needMentoring = "need_mentoring"
            case availableToMentor = "available_to_mentor"
        }
    }
    
    struct UpdateProfileResponseData: Decodable {
        let message: String?
    }

}
