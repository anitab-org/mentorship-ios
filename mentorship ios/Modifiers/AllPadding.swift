//
//  AllPadding.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 06/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

enum ScreenType {
    case screen, form
}

struct AllPadding: ViewModifier {
    let screenType: ScreenType
    
    func body(content: Content) -> some View {
        if screenType == .screen {
            return content
                .padding(.top, DesignConstants.Screen.Padding.topPadding)
                .padding(.bottom, DesignConstants.Screen.Padding.bottomPadding)
                .padding(.leading, DesignConstants.Screen.Padding.leadingPadding)
                .padding(.trailing, DesignConstants.Screen.Padding.trailingPadding)
        } else {
            return content
                .padding(.top, DesignConstants.Form.Padding.topPadding)
                .padding(.bottom, DesignConstants.Form.Padding.bottomPadding)
                .padding(.leading, DesignConstants.Form.Padding.leadingPadding)
                .padding(.trailing, DesignConstants.Form.Padding.trailingPadding)
        }
    }
}
