//
//  LoginModel.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

final class LoginModel {
   
    // MARK: - Structures
    struct LoginUploadData: Encodable {
        var username: String
        var password: String
    }
    
    struct SocialSignInData: Encodable {
        var idToken: String
        var name: String
        var email: String
        
        enum CodingKeys: String, CodingKey {
            case idToken = "id_token"
            case name, email
        }
    }
    
    enum SocialSignInType {
        case google, apple
    }

    struct LoginResponseData: Encodable {
        var message: String?
    }
}
