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
                        Text("Home")
                    }
            }.tag(0)

            //Members
            Members()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.members)
                            .imageScale(.large)
                        Text("Members")
                    }
            }.tag(1)
            
            //Settings
            Settings()
                .tabItem {
                    VStack {
                        Image(systemName: ImageNameConstants.SFSymbolConstants.settings)
                            .imageScale(.large)
                        Text("Settings")
                    }
            }.tag(2)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selection: .constant(1))
    }
}
