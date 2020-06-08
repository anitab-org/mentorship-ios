//
//  TabBar.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 08/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
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
