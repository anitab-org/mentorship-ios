//
//  RelationRequestActions.swift
//  Created on 07/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class RelationRequestActionAPI: ObservableObject {
    private var cancellable: AnyCancellable?
    var response = ResponseMessage(message: "")
    @Published var success = false
    
    enum ActionType {
        case accept, reject, delete     //for pending requests
        case cancel                     //for accepted request
    }
    
    func actOnPendingRequest(action: ActionType, reqID: Int) {
        var urlString = ""
        var httpMethod = "PUT"
        
        //initialise success to false
        success = false
        
        //set url string
        switch action {
        case .accept: urlString = URLStringConstants.MentorshipRelation.accept(reqID: reqID)
        case .reject: urlString = URLStringConstants.MentorshipRelation.reject(reqID: reqID)
        case .delete:
            urlString = URLStringConstants.MentorshipRelation.delete(reqID: reqID)
            httpMethod = "DELETE"
        case .cancel: urlString = URLStringConstants.MentorshipRelation.cancel(reqID: reqID)
        }
        
        //get token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(urlString: urlString, httpMethod: httpMethod, token: token)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.response) }
            .sink { [weak self] in
                self?.response = $0
                if NetworkManager.responseCode == 200 {
                    self?.success = true
                }
        }
    }
}

struct ResponseMessage: Decodable {
    let message: String?
}
