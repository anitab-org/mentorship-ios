//
//  ProfileViewModel.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    // MARK: - Variables
    let profileData = ProfileModel.ProfileData(
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
    @Published var updateProfileResponseData = ProfileModel.UpdateProfileResponseData(success: false, message: "")
    @Published var inActivity = false
    @Published var showAlert = false
    var alertTitle = LocalizedStringKey("")
    private var cancellable: AnyCancellable?
    

    // MARK: - Functions
    
    //saves profile in user defaults
    func saveProfile(profile: ProfileModel.ProfileData) {
        guard let profileData = try? JSONEncoder().encode(profile) else {
            return
        }
        UserDefaults.standard.set(profileData, forKey: UserDefaultsConstants.profile)
    }

    //gets profile object from user defaults
    func getProfile() -> ProfileModel.ProfileData {
        guard let profileData = UserDefaults.standard.data(forKey: UserDefaultsConstants.profile) else {
            return self.profileData
        }
        guard let profile = try? JSONDecoder().decode(ProfileModel.ProfileData.self, from: profileData) else {
            return self.profileData
        }
        return profile
    }
    
    //returns profile data with some processing to make it suitable for use in profile editor
    func getEditProfileData() -> ProfileModel.ProfileData {
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
    
    //func to save updated profile in user defaults
    func saveUpdatedProfile(updatedProfileData: ProfileModel.ProfileData) {
        var newProfileData = updatedProfileData
        newProfileData.username = getProfile().username
        self.saveProfile(profile: newProfileData)
    }
}
