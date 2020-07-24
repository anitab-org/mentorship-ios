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
    @Published var userName = ProfileViewModel().profileData.name
    @Published var isLoading = false
    var firstTimeLoad = true
    
    // MARK: - Functions
    func getSentDetailListData(userType: HomeModel.UserType, index: Int) -> [RequestStructure]? {
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
    
    func getReceivedDetailListData(userType: HomeModel.UserType, index: Int) -> [RequestStructure]? {
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
