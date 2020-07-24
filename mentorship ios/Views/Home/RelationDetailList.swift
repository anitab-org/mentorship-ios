//
//  RelationDetailList.swift
//  Created on 16/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct RelationDetailList: View {
    var index: Int
    var navigationTitle: String
    var homeViewModel: HomeViewModel
    @State private var pickerSelection = 1

    var sentData: [RequestStructure]? {
        if pickerSelection == 1 {
            return homeViewModel.getSentDetailListData(userType: .mentee, index: index)
        } else {
            return homeViewModel.getSentDetailListData(userType: .mentor, index: index)
        }
    }

    var receivedData: [RequestStructure]? {
        if pickerSelection == 1 {
            return homeViewModel.getReceivedDetailListData(userType: .mentee, index: index)
        } else {
            return homeViewModel.getReceivedDetailListData(userType: .mentor, index: index)
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
                //received data list
                Section(header: Text("Received").font(.headline)) {
                    ForEach(receivedData ?? []) { data in
                        DetailListCell(cellVM: DetailListCellViewModel(data: data), index: self.index)
                    }
                }
                
                //sent data list
                Section(header: Text("Sent").font(.headline)) {
                    ForEach(sentData ?? []) { data in
                        DetailListCell(cellVM: DetailListCellViewModel(data: data), index: self.index, sent: true)
                    }
                }
            }
        }
        .navigationBarTitle(navigationTitle)
    }
}

struct RelationDetailList_Previews: PreviewProvider {
    static var previews: some View {
        RelationDetailList(index: 0, navigationTitle: "", homeViewModel: HomeViewModel())
    }
}
