//
//  ContentView.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 30/05/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
            }.tag(0)
            
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
