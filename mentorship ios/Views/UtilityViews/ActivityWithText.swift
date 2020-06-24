//
//  ActivityWithText.swift
//  Created on 19/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct ActivityWithText: View {
    @Binding var isAnimating: Bool
    var textType: LocalizableStringConstants.ActivityTextKeys
    
    var body: some View {
        HStack {
            ActivityIndicator(isAnimating: $isAnimating, style: .medium)
            
            Text(textType.rawValue)
                .font(.callout)
        }
        .padding()
        .padding(.horizontal)
        .background(DesignConstants.Colors.formBackgroundColor)
        .cornerRadius(DesignConstants.CornerRadius.preferredCornerRadius)
    }
}

//struct ActivityWithText_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityWithText()
//    }
//}
