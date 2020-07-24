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
    
    //used in pagination for members list
    var currentPage = 0
    let perPage = 20
    var membersListFull = false
    
    // MARK: - Functions

    func availabilityString(canBeMentee: Bool, canBeMentor: Bool) -> LocalizedStringKey {
        if canBeMentor && canBeMentor {
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
    
}
