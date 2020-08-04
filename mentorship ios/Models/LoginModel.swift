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

    struct LoginResponseData: Encodable {
        var message: String?
    }
}
