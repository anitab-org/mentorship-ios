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

    //Direct values for english. To be used as keys for other languages.
    static let noAccountText = LocalizedStringKey("Don't have an account?")
    static let availabilityText = LocalizedStringKey("Available to be a:")
    static let mentee = LocalizedStringKey("Mentee")
    static let mentor = LocalizedStringKey("Mentor")
    static let tasksDone = LocalizedStringKey("Tasks Done")
    static let tasksToDo = LocalizedStringKey("Tasks To Do")
    static let endDate = LocalizedStringKey("End Date")
    static let notes = LocalizedStringKey("Notes")
    static let send = LocalizedStringKey("Send")
    static let cancel = LocalizedStringKey("Cancel")
    static let save = LocalizedStringKey("Save")
    static let profile = LocalizedStringKey("Profile")
    static let editProfile = LocalizedStringKey("Edit Profile")
    static let relationRequest = LocalizedStringKey("Relation Request")
    static let notAvailable = LocalizedStringKey("Not available")
    
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
}
