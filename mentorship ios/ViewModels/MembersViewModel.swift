//
//  MemberViewModel.swift
//  Created on 21/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import Combine

final class MembersViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var membersResponseData = [MembersModel.MembersResponseData]()
    @Published var sendRequestResponseData = MembersModel.SendRequestResponseData(message: "", success: false)
    @Published var inActivity = false
    @Published var searchString = ""
    
    //used in pagination for members list
    let perPage = 20
    var currentPage = 0
    var membersListFull = false
    
    var currentlySearching = false
    
    // to backup original data, restore back after search completes
    var tempCurrentPage = 0
    var tempMembersListFull = false
    var tempMembersResponse = [MembersModel.MembersResponseData]()
    
    // MARK: - Functions

    func availabilityString(canBeMentee: Bool, canBeMentor: Bool) -> LocalizedStringKey {
        if canBeMentee && canBeMentor {
            return LocalizableStringConstants.canBeBoth
        } else if canBeMentee {
            return LocalizableStringConstants.canBeMentee
        } else if canBeMentor {
            return LocalizableStringConstants.canBeMentor
        } else {
            return LocalizableStringConstants.notAvailable
        }
    }

    func skillsString(skills: String) -> String {
        return "Skills: \(skills)"
    }
    
    // purpose: save original data (non-filtered by search)
    func backup() {
        tempCurrentPage = currentPage
        tempMembersListFull = membersListFull
        tempMembersResponse = membersResponseData
    }
    
    // restore backed up data after cancel button pressed in search bar
    func restore() {
        currentPage = tempCurrentPage
        membersListFull = tempMembersListFull
        membersResponseData = tempMembersResponse
        currentlySearching = false
    }
    
}
