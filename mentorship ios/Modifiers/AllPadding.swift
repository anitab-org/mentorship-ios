//
//  AllPadding.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 06/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
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
