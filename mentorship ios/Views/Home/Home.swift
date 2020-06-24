//
//  Home.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    private var relationsData: UIHelper.HomeScreen.RelationsListData {
        return homeViewModel.relationsListData
    }
    private var profile: ProfileModel.ProfileData {
        return homeViewModel.profileData
    }

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
                        NavigationLink(destination: RelationDetailList(
                            index: index,
                            navigationTitle: self.relationsData.relationTitle[index],
                            homeViewModel: self.homeViewModel
                        )) {
                            RelationListCell(
                                systemImageName: self.relationsData.relationImageName[index],
                                imageColor: self.relationsData.relationImageColor[index],
                                title: self.relationsData.relationTitle[index],
                                count: self.relationsData.relationCount[index]
                            )
                        }
                        .disabled(self.homeViewModel.isLoading ? true : false)
                    }
                }

                //Tasks To Do list
                Section(header: Text(LocalizableStringConstants.tasksToDo).font(.headline)) {
                    ForEach(homeViewModel.homeResponseData.tasksToDo ?? []) { task in
                        HStack {
                            Image(systemName: ImageNameConstants.SFSymbolConstants.taskToDo)
                                .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                                .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)

                            Text(task.description ?? "-")
                                .font(.subheadline)
                        }
                    }
                }

                //Tasks Done list
                Section(header: Text(LocalizableStringConstants.tasksDone).font(.headline)) {
                    ForEach(homeViewModel.homeResponseData.tasksDone ?? []) { task in
                        HStack {
                            Image(systemName: ImageNameConstants.SFSymbolConstants.taskDone)
                                .foregroundColor(DesignConstants.Colors.defaultIndigoColor)
                                .padding(.trailing, DesignConstants.Padding.insetListCellFrameExpansion)

                            Text(task.description ?? "-")
                                .font(.subheadline)
                        }
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Welcome \(profile.name?.capitalized ?? "")!")
            .navigationBarItems(trailing:
                NavigationLink(destination: ProfileSummary()) {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.profileIcon)
                            .padding([.leading, .vertical])
                            .font(.system(size: DesignConstants.Fonts.Size.navBarIcon))
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
