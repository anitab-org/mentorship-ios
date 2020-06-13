//
//  ErrorText.swift
//  Created on 13/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ErrorText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignConstants.Fonts.userError)
            .foregroundColor(DesignConstants.Colors.userError)
    }
}
