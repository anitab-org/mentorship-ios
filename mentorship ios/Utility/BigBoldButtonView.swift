//
//  BigBoldButton.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 03/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import SwiftUI

struct BigBoldButtonView: View {
    let buttonText: String
    
    var body: some View {
        GeometryReader { geo in
            Text(self.buttonText)
                .frame(width: geo.size.width * 0.6, height: preferredHeight)
                .background(defaultIndigoColor)
                .foregroundColor(.white)
                .cornerRadius(preferredCornerRadius)
        }
    }
}

struct BigBoldButton_Previews: PreviewProvider {
    static var previews: some View {
        BigBoldButtonView(buttonText: "Login")
    }
}
