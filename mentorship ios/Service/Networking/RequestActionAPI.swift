//
//  RelationRequestActions.swift
//  Created on 07/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

enum ActionType {
    case accept, reject, delete     //for pending requests
    case cancel                     //for accepted request
}

class RequestActionAPI: RequestActionService {
    private var cancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func actOnPendingRequest(
        action: ActionType,
        reqID: Int,
        completion: @escaping (RequestActionResponse, Bool) -> Void
    ) {
        var urlString = ""
        var httpMethod = "PUT"
        
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
        cancellable = NetworkManager.callAPI(urlString: urlString, httpMethod: httpMethod, token: token, session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(RequestActionResponse(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 200
                completion($0, success)
        }
    }
}

