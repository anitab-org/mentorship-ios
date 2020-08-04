//
//  ProfileAPI.swift
//  Created on 22/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class ProfileAPI: ProfileService {
    private var cancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // get user profile from backend
    func getProfile(completion: @escaping (ProfileModel.ProfileData) -> Void) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        print(token)
        
        //parallel request for profile and home
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.user, token: token, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(ProfileViewModel().getProfile()) }
            .sink { profile in
                ProfileViewModel().saveProfile(profile: profile)
                completion(profile)
            }
    }
    
    // makes api call to update profile
    func updateProfile(
        updateProfileData: ProfileModel.ProfileData,
        completion: @escaping (ProfileModel.UpdateProfileResponseData) -> Void
    ) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //encoded upload data
        guard let uploadData = try? JSONEncoder().encode(updateProfileData) else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.user, httpMethod: "PUT", uploadData: uploadData, token: token, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(UpdateProfileNetworkModel(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 200
                let profileResponse = ProfileModel.UpdateProfileResponseData(success: success, message: $0.message)
                completion(profileResponse)
        }
    }
    
    struct UpdateProfileNetworkModel: Decodable {
        let message: String?
    }
}
