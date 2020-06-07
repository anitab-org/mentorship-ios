//
//  CustomTextField.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 03/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct RoundFilledTextFieldStyle: TextFieldStyle {
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(DesignConstants.Padding.frameExpansionPadding)
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.preferredCornerRadius)
                    .fill(DesignConstants.Colors.secondaryBackground)
        )
    }
}
