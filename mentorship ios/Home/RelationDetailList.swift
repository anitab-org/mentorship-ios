//
//  RelationDetailList.swift
//  Created on 16/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct RelationDetailList: View {
    var index: Int
    var navigationTitle: String
    var homeModel: HomeModel
    @State private var pickerSelection = 1

    var sentData: [HomeModel.HomeResponseData.RequestStructure]? {
        if pickerSelection == 1 {
            return homeModel.getSentDetailListData(userType: .mentee, index: index)
        } else {
            return homeModel.getSentDetailListData(userType: .mentor, index: index)
        }
    }

    var receivedData: [HomeModel.HomeResponseData.RequestStructure]? {
        if pickerSelection == 1 {
            return homeModel.getReceivedDetailListData(userType: .mentee, index: index)
        } else {
            return homeModel.getReceivedDetailListData(userType: .mentor, index: index)
        }
    }

    var body: some View {
        VStack {
            Picker(selection: $pickerSelection, label: Text("")) {
                Text("As Mentee").tag(1)
                Text("As Mentor").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            .padding()

            List {
                //send data list
                Section(header: Text("Sent").font(.headline)) {
                    ForEach(sentData ?? []) { data in
                        DetailListCell(requestData: data, index: self.index)
                    }
                }

                //received data list
                Section(header: Text("Received").font(.headline)) {
                    ForEach(receivedData ?? []) { data in
                        DetailListCell(requestData: data, index: self.index)
                    }
                }
            }
        }
        .navigationBarTitle(navigationTitle)
    }
}

struct RelationDetailList_Previews: PreviewProvider {
    static var previews: some View {
        RelationDetailList(index: 0, navigationTitle: "", homeModel: HomeModel())
    }
}
