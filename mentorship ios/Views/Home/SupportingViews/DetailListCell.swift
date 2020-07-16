//
//  DetailListCell.swift
//  Created on 17/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct DetailListCell: View {
    var relationRequestActionAPI = RelationRequestActionAPI()
    var requestData: HomeModel.HomeResponseData.RequestStructure
    var index: Int
    var sent = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertButtonText = LocalizedStringKey("")
    @State private var actionType: RelationRequestActionAPI.ActionType!
    @Environment(\.presentationMode) var presentationMode

    var endDate: Date {
        return Date(timeIntervalSince1970: requestData.endDate ?? 0)
    }
    
    //alert action,. To accept, delete, reject, or withdraw a request
    func alertAction() {
        guard let reqID = self.requestData.id else { return }
        self.relationRequestActionAPI.actOnPendingRequest(action: self.actionType, reqID: reqID)
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
                Text("Mentee: \(requestData.mentee?.userName ?? "-")")
                Spacer()
                Text("Mentor: \(requestData.mentor?.userName ?? "-")")
            }
            .font(.subheadline)
            .foregroundColor(DesignConstants.Colors.defaultIndigoColor)

            Text(!requestData.notes!.isEmpty ? requestData.notes! : "No Note Present")
                .font(.headline)
                .opacity(requestData.notes!.isEmpty ? DesignConstants.Opacity.disabledViewOpacity/2 : 1.0)

            Text("End Date: \(DesignConstants.DateFormat.mediumDate.string(from: endDate))")
                .font(.caption)
            
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
        .onReceive(relationRequestActionAPI.$success) { actionSuccessful in
            if actionSuccessful {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
