//
//  CustomTextField.swift
//  Created on 03/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct RoundFilledTextFieldStyle: TextFieldStyle {
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(DesignConstants.Padding.textFieldFrameExpansion)
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.preferredCornerRadius)
                    .fill(DesignConstants.Colors.secondaryBackground)
        )
    }
}
