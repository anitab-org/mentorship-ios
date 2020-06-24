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

    struct LoginResponseData: Decodable {
        let message: String?
        let accessToken: String?

        enum CodingKeys: String, CodingKey {
            case message
            case accessToken = "access_token"
        }
    }
}
