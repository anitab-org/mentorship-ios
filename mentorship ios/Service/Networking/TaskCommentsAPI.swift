//
//  TaskCommentsAPI.swift
//  Created on 28/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

class TaskCommentsAPI: TaskCommentsService {
    private var cancellable: AnyCancellable?
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchTaskComments(
        reqID: Int,
        taskID: Int,
        completion: @escaping ([TaskCommentsModel.TaskCommentsResponse]) -> Void
    ) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(
            urlString: URLStringConstants.MentorshipRelation.getTaskComments(reqID: reqID, taskID: taskID),
            token: token,
            session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just([CommentsNetworkResponse]()) }
            .sink { comments in
                var response = [TaskCommentsModel.TaskCommentsResponse]()
                for comment in comments {
                    response.append(.init(id: comment.id, userID: comment.userID, creationDate: comment.creationDate, comment: comment.comment))
                }
                response = response.sorted()
                completion(response)
        }
    }
    
    func postTaskComment(
        reqID: Int,
        taskID: Int,
        commentData: TaskCommentsModel.PostCommentUploadData,
        completion: @escaping (TaskCommentsModel.PostCommentResponse) -> Void
    ) {
        //get auth token
        guard let token = try? KeychainManager.getToken() else {
            return
        }
        
        // encode upload data
        guard let uploadData = try? JSONEncoder().encode(commentData) else {
            return
        }
        
        //api call
        cancellable = NetworkManager.callAPI(
            urlString: URLStringConstants.MentorshipRelation.postTaskComment(reqID: reqID, taskID: taskID),
            httpMethod: "POST",
            uploadData: uploadData,
            token: token,
            session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just(PostCommentResponse(message: LocalizableStringConstants.networkErrorString)) }
            .sink {
                let success = NetworkManager.responseCode == 201
                let response = TaskCommentsModel.PostCommentResponse(message: $0.message, success: success)
                completion(response)
        }
    }
    
    struct CommentsNetworkResponse: Decodable {
        let id: Int?
        let userID: Int?
        let creationDate: Double?
        let comment: String?
        
        enum CodingKeys: String, CodingKey {
            case id, comment
            case userID = "user_id"
            case creationDate = "creation_date"
        }
    }
    
    struct PostCommentResponse: Decodable {
        let message: String?
    }
}
