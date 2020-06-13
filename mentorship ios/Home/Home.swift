//
//  Home.swift
//  Created on 05/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeModel = HomeModel()
    var body: some View {
        Text("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
