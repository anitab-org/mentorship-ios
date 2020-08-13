//
//  TaskCommentCell.swift
//  Created on 07/08/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TaskCommentCell: View {
    let comment: TaskCommentsModel.TaskCommentsResponse
    let userID: Int
    @EnvironmentObject var taskCommentsVM: TaskCommentsViewModel
    @State var showActionSheet = false
    
    func showReportCommentAlert() {
        self.taskCommentsVM.taskCommentIDToReport = self.comment.id
        self.taskCommentsVM.showReportViolationAlert.toggle()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.Form.Spacing.minimalSpacing) {
            // Sender name and time
            VStack(alignment: .leading, spacing: DesignConstants.Spacing.minimalSpacing) {
                // Name and ellipsis icon to show action sheet (if comment by other person)
                HStack {
                    Text(self.taskCommentsVM.getCommentAuthorName(authorID: comment.userID!, userID: userID))
                        .font(.headline)
                    
                    Spacer()
                    
                    if comment.userID != self.userID {
                        Button(action: {
                            self.showActionSheet.toggle()
                        }) {
                            Image(systemName: ImageNameConstants.SFSymbolConstants.ellipsis)
                                .imageScale(.large)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                
                // Datetime of comment
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
        .contextMenu {
            // If comment is by other person, show report violation button
            if comment.userID != self.userID {
                Button(action: {
                    self.showReportCommentAlert()
                }) {
                    HStack {
                        Text(LocalizableStringConstants.reportComment)
                        Image(systemName: ImageNameConstants.SFSymbolConstants.reportComment)
                    }
                }
            }
        }
        .actionSheet(isPresented: self.$showActionSheet) {
            ActionSheet(
                title: Text(LocalizableStringConstants.actionsforComment),
                message: Text(comment.comment ?? ""),
                buttons: [
                    .destructive(Text(LocalizableStringConstants.reportComment), action: {
                        self.showReportCommentAlert()
                    }),
                    .cancel()
            ])
        }
    }
}
