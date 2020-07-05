//
//  TabBar.swift
//  Created on 08/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct TabBar: View {
    @Binding var selection: Int

    var body: some View {
        TabView(selection: $selection) {
            //Home
            Home()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.home)
                            .imageScale(.large)
                        Text(LocalizableStringConstants.ScreenNames.home)
                    }
            }.tag(0)
            
            //Relation
            Relation()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.relation)
                            .imageScale(.large)
                        Text(LocalizableStringConstants.ScreenNames.relation)
                    }
            }.tag(1)

            //Members
            Members()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.members)
                            .imageScale(.large)
                        Text(LocalizableStringConstants.ScreenNames.members)
                    }
            }.tag(2)
            
            //Settings
            Settings()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.settings)
                            .imageScale(.large)
                        Text(LocalizableStringConstants.ScreenNames.settings)
                    }
            }.tag(3)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selection: .constant(1))
    }
}
