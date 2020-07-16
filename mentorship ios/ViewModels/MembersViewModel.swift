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
    @Published var sendRequestResponseData = MembersModel.SendRequestResponseData(message: "")
    @Published var inActivity = false
    @Published var requestSentSuccesfully = false
    private var cancellable: AnyCancellable?

    // MARK: - Functions

    //Fetch Members
    func fetchMembers() {
        guard let token = try? KeychainManager.getToken() else {
            return
        }

        self.inActivity = true

        // Debug comment: cache policy to be changed later to revalidateCache
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.Users.members, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.membersResponseData) }
            .sink(receiveCompletion: { completion in
                if completion == .finished {
                    self.inActivity = false
                }
            }, receiveValue: { value in
                self.membersResponseData = value
            })
    }

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

    //Send Request
    func sendRequest(menteeID: Int, mentorID: Int, endDate: Double, notes: String) {
        //token
        guard let token = try? KeychainManager.getToken() else {
            return
        }

        //upload data
        let requestData = MembersModel.SendRequestUploadData(mentorID: mentorID, menteeID: menteeID, endDate: endDate, notes: notes)
        NSLog("A relation request was made to the server.")
        guard let uploadData = try? JSONEncoder().encode(requestData) else {
            return
        }

        //activity indicator
        self.inActivity = true

        //api call
        cancellable = NetworkManager.callAPI(urlString: URLStringConstants.MentorshipRelation.sendRequest, httpMethod: "POST", uploadData: uploadData, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.sendRequestResponseData) }
            .sink(receiveCompletion: { _ in
                self.inActivity = false
                if NetworkManager.responseCode == 200 {
                    self.requestSentSuccesfully = true
                }
            }, receiveValue: { value in
                self.sendRequestResponseData = value
            })
    }
    
}
