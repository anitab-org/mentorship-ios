//
//  DetailListCell.swift
//  Created on 17/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct DetailListCell: View {
    var requestActionService: RequestActionService = RequestActionAPI()
    var cellVM: DetailListCellViewModel
    var index: Int
    var sent = false
    @State private var actionType: ActionType!
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertButtonText = LocalizedStringKey("")
    @Environment(\.presentationMode) var presentationMode
    
    // Alert action. To accept, delete, reject, or withdraw a request
    func alertAction() {
        guard let reqID = self.cellVM.requestData.id else { return }
        requestActionService.actOnPendingRequest(action: actionType, reqID: reqID) {_, success in
            // if call successful, pop navigation controller and go back to home screen
            if success {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var alertActionButton: Alert.Button {
        //if action is to accept. Make alert button default
        if actionType == .accept {
            return Alert.Button.default(Text(alertButtonText)) {
                self.alertAction()
            }
        }
        //else if action is delete, reject, or withdraw. Make alert button destructive
        else {
            return Alert.Button.destructive(Text(alertButtonText)) {
                self.alertAction()
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.Form.Spacing.smallSpacing) {
            HStack {
                Text("Mentee: \(cellVM.requestData.mentee?.userName ?? "-")")
                Spacer()
                Text("Mentor: \(cellVM.requestData.mentor?.userName ?? "-")")
            }
            .font(.subheadline)
            .foregroundColor(DesignConstants.Colors.defaultIndigoColor)

            Text(!cellVM.requestData.notes!.isEmpty ? cellVM.requestData.notes! : "No Note Present")
                .font(.headline)
                .opacity(cellVM.requestData.notes!.isEmpty ? DesignConstants.Opacity.disabledViewOpacity/2 : 1.0)

            Text("End Date: \(self.cellVM.endDate)")
                .font(.caption)
            
            // MARK: - Action Buttons. For pending and accepted requests.
            //Buttons to accept, reject, delete for pending requests
            if index == 0 {
                //show cancel button for sent requests
                if sent {
                    Button(LocalizableStringConstants.RequestActions.delete) {
                        self.alertTitle = "Delete Request?"
                        self.alertButtonText = LocalizableStringConstants.RequestActions.delete
                        self.actionType = .delete
                        self.showAlert.toggle()
                    }
                    .foregroundColor(.red)
                    .buttonStyle(BorderlessButtonStyle())
                }
                //show accept or reject button for received requests
                else {
                    HStack {
                        //Accept button
                        Button(LocalizableStringConstants.RequestActions.accept) {
                            self.alertTitle = "Accept Request?"
                            self.alertButtonText = LocalizableStringConstants.RequestActions.accept
                            self.actionType = .accept
                            self.showAlert.toggle()
                        }
                        .foregroundColor(DesignConstants.Colors.accepted)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        //spacer
                        Spacer()
                        
                        //Reject button
                        Button(LocalizableStringConstants.RequestActions.reject) {
                            self.alertTitle = "Reject Request?"
                            self.alertButtonText = LocalizableStringConstants.RequestActions.reject
                            self.actionType = .reject
                            self.showAlert.toggle()
                        }
                        .foregroundColor(DesignConstants.Colors.rejected)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            //Button to cancel accepted request
            else if index == 1 {
                Button(LocalizableStringConstants.RequestActions.cancel) {
                    self.alertTitle = "Withdraw Relation?"
                    self.alertButtonText = LocalizableStringConstants.RequestActions.cancel
                    self.actionType = .cancel
                    self.showAlert.toggle()
                }
                .foregroundColor(DesignConstants.Colors.cancelled)
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(.vertical)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(self.alertTitle),
                primaryButton: .cancel(),
                secondaryButton: alertActionButton
            )
        }
    }
}
