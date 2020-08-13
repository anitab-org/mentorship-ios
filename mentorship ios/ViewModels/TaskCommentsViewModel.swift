//
//  TaskCommentsViewModel.swift
//  Created on 28/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Combine

class TaskCommentsViewModel: ObservableObject {
    @Published var taskCommentsResponse = [TaskCommentsModel.TaskCommentsResponse]()
    @Published var newComment = TaskCommentsModel.PostCommentUploadData(comment: "")
    // isLoading state, used to show activity indicator while loading.
    @Published var isLoading = false
    // Initially only the latest comments are shown and earlier comments are hidden.
    // Used to handle this state. Also, the button to 'Show Earlier' uses this and is only shown if required.
    @Published var showingEarlier = false
    // Show message alert if task not added successfully or after report comment operation completes
    @Published var showMessageAlert = false
    // Show alert to confirm reporting of a task comment action
    @Published var showReportViolationAlert = false
    // Report of comment in activity, true while service being used
    @Published var reportCommentInActivity = false
    var taskCommentIDToReport = -1
    
    // limit of number of latest comments to show
    let latestCommentsLimit = 4
    // name of other member in relation
    var reqName: String = ""
    // relation id
    var reqID: Int = -1
    
    // Check if number of comments are more than set limit to show latest comments.
    // Used by 'Show Earlier' button to only be visible when required.
    var commentsMoreThanLimit: Bool {
        return taskCommentsResponse.count > latestCommentsLimit
    }
    
    // Filter comments to be shown. Show all if showEarlier is enabled, else show latest only as per limit.
    var commentsToShow: [TaskCommentsModel.TaskCommentsResponse] {
        if showingEarlier {
            return taskCommentsResponse
        } else {
            return Array(taskCommentsResponse.suffix(latestCommentsLimit))
        }
    }
    
    var sendButtonDisabled: Bool {
        return newComment.comment.isEmpty
    }
    
    // Get comment author name.
    func getCommentAuthorName(authorID: Int, userID: Int) -> String {
        // if author id is same as user id, then author is user.
        if authorID == userID {
            return LocalizableStringConstants.you
        }
        // else author is other person in the mentorship relation
        else {
            return reqName
        }
    }
}
