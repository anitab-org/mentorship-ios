//
//  CustomSecureField.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 03/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct CustomSecureField: View {
    let placeholder: String
    @Binding var fieldValue: String
    
    var body: some View {
        SecureField(placeholder, text: $fieldValue)
            .padding(preferredPadding)
            .background(
                RoundedRectangle(cornerRadius: preferredCornerRadius)
                    .fill(secondaryBackground)
        )
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(placeholder: "Placeholder", fieldValue: .constant("Value"))
    }
}
