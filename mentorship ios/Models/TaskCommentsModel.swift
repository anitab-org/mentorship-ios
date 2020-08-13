//
//  TaskCommentsModel.swift
//  Created on 28/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

class TaskCommentsModel {
    struct TaskCommentsResponse: Identifiable, Encodable, Comparable {
        
        // sorting logic added, to have comments in ascending order of creation date
        static func < (lhs: TaskCommentsModel.TaskCommentsResponse, rhs: TaskCommentsModel.TaskCommentsResponse) -> Bool {
            lhs.creationDate ?? 0 < rhs.creationDate ?? 0
        }
        
        let id: Int
        let userID: Int?
        let creationDate: Double?
        let comment: String?
    }
    
    struct PostCommentUploadData: Encodable {
        var comment: String
    }
    
    struct MessageResponse: Encodable {
        let message: String?
        let success: Bool
    }
}
