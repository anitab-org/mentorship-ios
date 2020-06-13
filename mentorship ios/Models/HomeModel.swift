//
//  HomeModel.swift
//  Created on 12/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI
import Combine

final class HomeModel: ObservableObject {
    // MARK: - Variables
    @Published var homeResponseData = HomeResponseData()
    var profileModel = ProfileModel()
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    init() {
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        print(token)
        
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.home)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.homeResponseData) }
            .combineLatest(
                NetworkManager.callAPI(urlString: URLStringConstants.Users.getProfile, token: token, cachePolicy: .returnCacheDataElseLoad)
                    .receive(on: RunLoop.main)
                    .catch { _ in Just(self.profileModel.profileData) }
            )
            .sink { home, profile in
                print(profile)
                self.profileModel.saveProfile(profile: profile)
                print(self.profileModel.getProfile())
            }
    }
    
    // MARK: - Structures
    struct HomeResponseData: Decodable {
    }
    
}
