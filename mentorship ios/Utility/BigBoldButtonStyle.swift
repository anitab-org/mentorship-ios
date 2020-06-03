//
//  BigBoldButton.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 03/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct BigBoldButtonStyle: ButtonStyle {
    var disabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200)
            .padding(.vertical, preferredPadding)
            .background(defaultIndigoColor)
            .foregroundColor(Color(.systemBackground))
            .cornerRadius(preferredCornerRadius)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .opacity(disabled ? 0.5 : 1.0)
    }
}
