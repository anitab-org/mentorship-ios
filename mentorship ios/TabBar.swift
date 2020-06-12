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
            Home()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
            }.tag(0)
            
            Members()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
            }.tag(1)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selection: .constant(1))
    }
}
