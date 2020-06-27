//
//  URLConstants.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

let baseURL: String = "https://mentorship-backend-temp.herokuapp.com/"

struct URLStringConstants {
    struct Users {
        static let login: String = baseURL + "login"
        static let signUp: String = baseURL + "register"
        static let members: String = baseURL + "users"
        static let home: String = baseURL + "dashboard"
        static let profile: String = baseURL + "user"
        static let changePassword: String = baseURL + "/user/change_password"
    }

    struct MentorshipRelation {
        static let sendRequest: String = baseURL + "mentorship_relation/send_request"
    }
    
    struct WebsiteURLs {
        static let privacyPolicy = "https://anitab.org/privacy-policy/"
        static let termsOfUse = "https://anitab.org/terms-of-use/"
    }
}
