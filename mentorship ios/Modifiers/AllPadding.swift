//
//  AllPadding.swift
//  Created on 06/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct AllPadding: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.top, DesignConstants.Screen.Padding.topPadding)
            .padding(.bottom, DesignConstants.Screen.Padding.bottomPadding)
            .padding(.leading, DesignConstants.Screen.Padding.leadingPadding)
            .padding(.trailing, DesignConstants.Screen.Padding.trailingPadding)
    }
}
