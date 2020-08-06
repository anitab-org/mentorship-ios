//
//  StringConstants.swift
//  Created on 04/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct LocalizableStringConstants {
    //Strictly keys - localized in localizable.strings file
    static let tncString = LocalizedStringKey("Terms and conditions")
    static let canBeBoth = LocalizedStringKey("Can be both")
    static let canBeMentee = LocalizedStringKey("Can be mentee")
    static let canBeMentor = LocalizedStringKey("Can be mentor")
    static let aboutText = LocalizedStringKey("About text")
    static let operationFail = LocalizedStringKey("Operation failed")
    
    // Not localizable. Reason: used in network requests, backend returns string.
    static let networkErrorString = "Network error. Please check your device network and try again."
    static let passwordsDoNotMatch = "Passwords do not match"
    static let you = "You"

    //Direct values for english. To be used as keys for other languages.
    static let noAccountText = LocalizedStringKey("Don't have an account?")
    static let availabilityText = LocalizedStringKey("Available to be a:")
    static let mentee = LocalizedStringKey("Mentee")
    static let mentor = LocalizedStringKey("Mentor")
    static let tasksDone = LocalizedStringKey("Tasks Done")
    static let tasksToDo = LocalizedStringKey("Tasks To Do")
    static let showEarlier = LocalizedStringKey("Show Earlier")
    static let enterComment = LocalizedStringKey("Enter comment")
    static let endDate = LocalizedStringKey("End Date")
    static let notes = LocalizedStringKey("Notes")
    static let send = LocalizedStringKey("Send")
    static let cancel = LocalizedStringKey("Cancel")
    static let save = LocalizedStringKey("Save")
    static let okay = LocalizedStringKey("Okay")
    static let confirm = LocalizedStringKey("Confirm")
    static let success = LocalizedStringKey("Success")
    static let failure = LocalizedStringKey("Failure")
    static let profile = LocalizedStringKey("Profile")
    static let editProfile = LocalizedStringKey("Edit Profile")
    static let addTask = LocalizedStringKey("Add Task")
    static let markComplete = LocalizedStringKey("Mark as complete")
    static let relationRequest = LocalizedStringKey("Relation Request")
    static let notAvailable = LocalizedStringKey("Not available")
    static let privacyPolicy = LocalizedStringKey("Privacy Policy")
    static let termsOfUse = LocalizedStringKey("Terms of Use")
    
    // MARK: - Categorized
    
    //Keys to be used for Screen Names. (Direct values for English)
    struct ScreenNames {
        static let home = LocalizedStringKey("Home")
        static let relation = LocalizedStringKey("Relation")
        static let members = LocalizedStringKey("Members")
        static let settings = LocalizedStringKey("Settings")
        static let comments = LocalizedStringKey("Comments")
    }
    
    //Key to be used for relation request actions. (Direct values for English)
    struct RequestActions {
        static let accept = LocalizedStringKey("Accept")
        static let reject = LocalizedStringKey("Reject")
        static let delete = LocalizedStringKey("Delete")
        static let cancel = LocalizedStringKey("Withdraw")
    }
    
    //Keys to be used for profile attributes. (Direct values for English)
    enum ProfileKeys: LocalizedStringKey {
        case name = "Name"
        case username = "Username"
        case slackUsername = "Slack Username"
        case isMentor = "Is a Mentor"
        case needsMentor = "Needs a Mentor"
        case interests = "Interests"
        case bio = "Bio"
        case location = "Location"
        case occupation = "Occupation"
        case organization = "Organization"
        case skills = "Skills"
        case email = "Email"
    }
    
    //Keys to be used for text in ActivityWithText view. (Direct values for English)
    //Value string convention: All capitalized
    enum ActivityTextKeys: LocalizedStringKey {
        case updating = "UPDATING"
    }
}
