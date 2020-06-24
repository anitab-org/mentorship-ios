//
//  ProfileEditField.swift
//  Created on 18/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ProfileEditField: View {
    var type: LocalizableStringConstants.ProfileKeys
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(type.rawValue)
                .bold()
                .frame(width: DesignConstants.Width.listCellTitle)
                .multilineTextAlignment(.center)
            Divider()
            TextField(type.rawValue, text: $value)
        }
    }
}

struct ProfileEditField_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditField(type: .bio, value: .constant("value"))
    }
}
