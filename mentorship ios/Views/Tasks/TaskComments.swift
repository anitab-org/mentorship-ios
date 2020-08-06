//
//  TaskComments.swift
//  Created on 15/07/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TaskComments: View {
    let taskCommentsService: TaskCommentsService = TaskCommentsAPI()
    @EnvironmentObject var taskCommentsVM: TaskCommentsViewModel
    let taskID: Int
    let taskName: String
    let userID = ProfileViewModel().getProfile().id
    
    func fetchComments() {
        taskCommentsService.fetchTaskComments(reqID: taskCommentsVM.reqID, taskID: taskID) { comments in
            self.taskCommentsVM.isLoading = false
            self.taskCommentsVM.taskCommentsResponse = comments
        }
    }
    
    func postComment() {
        self.taskCommentsService.postTaskComment(
            reqID: self.taskCommentsVM.reqID,
            taskID: self.taskID,
            commentData: self.taskCommentsVM.newComment
        ) { resp in
            // update view model with responses
            self.taskCommentsVM.postCommentResponse = resp
            // if post comment successful, update comments and clear text field
            if resp.success {
                self.fetchComments()
                self.taskCommentsVM.newComment.comment = ""
            }
            // else, show error alert
            else {
                self.taskCommentsVM.showErrorAlert = true
            }
        }
    }
    
    func commentCell(comment: TaskCommentsModel.TaskCommentsResponse) -> some View {
        // Comment cell
        VStack(alignment: .leading, spacing: DesignConstants.Form.Spacing.minimalSpacing) {
            // Sender name and time
            HStack {
                Text(self.taskCommentsVM.getCommentAuthorName(authorID: comment.userID!, userID: userID))
                    .font(.headline)
                
                Spacer()
                
                Text(DesignConstants.DateFormat.taskTime.string(from: Date(timeIntervalSince1970: comment.creationDate ?? 0)))
                    .font(.footnote)
                    .foregroundColor(DesignConstants.Colors.subtitleText)
            }
            .padding(.vertical, DesignConstants.Padding.textInListCell)
            
            // Comment
            Text(comment.comment ?? "")
                .font(.subheadline)
                .padding(.bottom, DesignConstants.Padding.textInListCell)
        }
    }
    
    var body: some View {
        VStack {
            // List showing comments
            List {
                //heading
                Section(header: Text(self.taskName).font(.title).bold()) {
                    EmptyView()
                }
                
                // activity indicator, show when comments screen first accessed
                if self.taskCommentsVM.isLoading {
                    ActivityIndicator(isAnimating: .constant(true))
                }
                    // task comments
                else {
                    if !taskCommentsVM.showingEarlier && taskCommentsVM.commentsMoreThanLimit {
                        Button(LocalizableStringConstants.showEarlier) {
                            self.taskCommentsVM.showingEarlier = true
                        }
                    }
                    ForEach(taskCommentsVM.commentsToShow) { comment in
                        self.commentCell(comment: comment)
                    }
                }
            }
            
            // Text field at bottom with send button
            HStack {
                // Text Field
                TextField(LocalizableStringConstants.enterComment, text: $taskCommentsVM.newComment.comment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Send Button
                Button(LocalizableStringConstants.send) {
                    self.postComment()
                }
                .disabled(self.taskCommentsVM.sendButtonDisabled)
            }
            .padding(.horizontal)
            .modifier(KeyboardAware())
            
            // Spacer for bottom
            Spacer()
        }
        .navigationBarTitle(LocalizableStringConstants.ScreenNames.comments)
        .onAppear {
            self.taskCommentsVM.isLoading = true
            self.taskCommentsVM.showingEarlier = false
            self.fetchComments()
        }
        .alert(isPresented: self.$taskCommentsVM.showErrorAlert) {
            return Alert(
                title: Text(LocalizableStringConstants.failure),
                message: Text(self.taskCommentsVM.postCommentResponse.message ?? LocalizableStringConstants.networkErrorString),
                dismissButton: .default(Text(LocalizableStringConstants.okay))
            )
        }
    }
}

struct TaskComments_Previews: PreviewProvider {
    static var previews: some View {
        TaskComments(taskID: 0, taskName: "Test task")
    }
}
