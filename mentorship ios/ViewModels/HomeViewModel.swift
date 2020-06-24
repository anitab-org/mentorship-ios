//
//  HomeViewModel.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var homeResponseData = HomeModel.HomeResponseData(asMentor: nil, asMentee: nil, tasksToDo: nil, tasksDone: nil)
    @Published var relationsListData = UIHelper.HomeScreen.RelationsListData()
    @Published var profileData = ProfileViewModel().profileData
    var profileViewModel = ProfileViewModel()
    var isLoading: Bool = false
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    init() {
        //get auth token
        guard let token = try? KeychainManager.readKeychain() else {
            return
        }
        print(token)
        
        //used to express loading state in UI in home screen
        isLoading = true
        
        //parallel request for profile and home
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.home, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.homeResponseData) }
            .combineLatest(
                NetworkManager.callAPI(urlString: URLStringConstants.Users.profile, token: token)
                    .receive(on: RunLoop.main)
                    .catch { _ in Just(self.profileViewModel.getProfile()) }
            )
            .sink { home, profile in
                self.profileViewModel.saveProfile(profile: profile)
                self.profileData = profile
                self.updateCount(homeData: home)
                self.homeResponseData = home
                self.isLoading = false
        }
    }
    
    func updateCount(homeData: HomeModel.HomeResponseData) {
        var pendingCount = homeData.asMentee?.sent?.pending?.count ?? 0
        pendingCount += homeData.asMentee?.received?.pending?.count ?? 0
        pendingCount += homeData.asMentor?.sent?.pending?.count ?? 0
        pendingCount += homeData.asMentor?.received?.pending?.count ?? 0
        
        var acceptedCount = homeData.asMentee?.sent?.accepted?.count ?? 0
        acceptedCount += homeData.asMentee?.received?.accepted?.count ?? 0
        acceptedCount += homeData.asMentor?.sent?.accepted?.count ?? 0
        acceptedCount += homeData.asMentor?.received?.accepted?.count ?? 0
        
        var rejectedCount = homeData.asMentee?.sent?.rejected?.count ?? 0
        rejectedCount += homeData.asMentee?.received?.rejected?.count ?? 0
        rejectedCount += homeData.asMentor?.sent?.rejected?.count ?? 0
        rejectedCount += homeData.asMentor?.received?.rejected?.count ?? 0
        
        var cancelledCount = homeData.asMentee?.sent?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentee?.received?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentor?.sent?.cancelled?.count ?? 0
        cancelledCount += homeData.asMentor?.received?.cancelled?.count ?? 0
        
        var completedCount = homeData.asMentee?.sent?.completed?.count ?? 0
        completedCount += homeData.asMentee?.received?.completed?.count ?? 0
        completedCount += homeData.asMentor?.sent?.completed?.count ?? 0
        completedCount += homeData.asMentor?.received?.completed?.count ?? 0
        
        self.relationsListData.relationCount = [pendingCount, acceptedCount, rejectedCount, cancelledCount, completedCount]
    }
    
    func getSentDetailListData(userType: HomeModel.UserType, index: Int) -> [HomeModel.HomeResponseData.RequestStructure]? {
        if userType == .mentee {
            let data1 = homeResponseData.asMentee?.sent
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        } else {
            let data1 = homeResponseData.asMentor?.sent
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        }
    }
    
    func getReceivedDetailListData(userType: HomeModel.UserType, index: Int) -> [HomeModel.HomeResponseData.RequestStructure]? {
        if userType == .mentee {
            let data1 = homeResponseData.asMentee?.received
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        } else {
            let data1 = homeResponseData.asMentor?.received
            switch index {
            case 0: return data1?.pending
            case 1: return data1?.accepted
            case 2: return data1?.rejected
            case 3: return data1?.cancelled
            case 4: return data1?.completed
            default: return []
            }
        }
    }
}
