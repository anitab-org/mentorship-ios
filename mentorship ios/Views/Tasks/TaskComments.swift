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
    @State var messageAlertTitle = LocalizedStringKey("")
    @State var messageAlertMessage = ""
    
    // Use service to fetch task comment
    func fetchComments() {
        taskCommentsService.fetchTaskComments(reqID: taskCommentsVM.reqID, taskID: taskID) { comments in
            self.taskCommentsVM.isLoading = false
            self.taskCommentsVM.taskCommentsResponse = comments
        }
    }
    
    // Use service to post a new comment
    func postComment() {
        self.taskCommentsService.postTaskComment(
            reqID: self.taskCommentsVM.reqID,
            taskID: self.taskID,
            commentData: self.taskCommentsVM.newComment
        ) { resp in
            // if post comment successful, update comments and clear text field
            if resp.success {
                self.fetchComments()
                self.taskCommentsVM.newComment.comment = ""
            }
                // else, show error alert
            else {
                self.taskCommentsVM.showMessageAlert = true
                self.messageAlertTitle = LocalizableStringConstants.failure
                self.messageAlertMessage = resp.message ?? LocalizableStringConstants.networkErrorString
            }
        }
    }
    
    // Use service to report a comment for violation of code of conduct
    func reportComment() {
        taskCommentsVM.reportCommentInActivity = true
        taskCommentsService.reportComment(reqID: taskCommentsVM.reqID, taskID: taskID, commentID: taskCommentsVM.taskCommentIDToReport) { resp in
            // set in activity to false
            self.taskCommentsVM.reportCommentInActivity = false
            // show message alert
            self.taskCommentsVM.showMessageAlert = true
            // set alert title and message
            self.messageAlertTitle = resp.success ? LocalizableStringConstants.success : LocalizableStringConstants.failure
            self.messageAlertMessage = resp.message ?? LocalizableStringConstants.networkErrorString
        }
    }
    
    var body: some View {
        ZStack {
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
                            TaskCommentCell(comment: comment, userID: self.userID)
                                .alert(isPresented: self.$taskCommentsVM.showReportViolationAlert) {
                                    Alert(
                                        title: Text(LocalizableStringConstants.reportComment),
                                        message: Text(LocalizableStringConstants.reportCommentMessage),
                                        primaryButton: .cancel(),
                                        secondaryButton: .destructive(Text(LocalizableStringConstants.report)) {
                                            self.reportComment()
                                        }
                                    )
                            }
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
            
            if taskCommentsVM.reportCommentInActivity {
                ActivityWithText(isAnimating: .constant(true), textType: .reporting)
            }
        }
        .navigationBarTitle(LocalizableStringConstants.ScreenNames.comments)
        .onAppear {
            self.taskCommentsVM.isLoading = true
            self.taskCommentsVM.showingEarlier = false
            self.fetchComments()
        }
        .alert(isPresented: self.$taskCommentsVM.showMessageAlert) {
            Alert(
                title: Text(messageAlertTitle),
                message: Text(messageAlertMessage),
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
