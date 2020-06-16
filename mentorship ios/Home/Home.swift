//
//  Home.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeModel = HomeModel()
    var relationsData: HomeModel.RelationsListData {
        return homeModel.relationsListData
    }
    private let profile = ProfileModel().getProfile()

    var body: some View {
        NavigationView {
            List {
                //Top space
                Section {
                    EmptyView()
                }

                //Relation dashboard list
                Section {
                    ForEach(0 ..< relationsData.relationTitle.count) { index in
                        NavigationLink(destination: Text("Hi")) {
                            RelationListCell(
                                systemImageName: self.relationsData.relationImageName[index],
                                imageColor: self.relationsData.relationImageColor[index],
                                title: self.relationsData.relationTitle[index],
                                count: self.relationsData.relationCount[index]
                            )
                                .opacity(self.homeModel.isLoading ? 0.5 : 1.0)
                        }
                    }
                }

                //Tasks done list
                Section(header: Text("Tasks Done").font(.headline)) {
                    ForEach(1..<3) { index in
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(DesignConstants.Colors.defaultIndigoColor)

                                .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)
                            Text("Task \(index) description")
                                .font(.subheadline)
                        }
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Welcome \(profile.name?.capitalized ?? "")!")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
