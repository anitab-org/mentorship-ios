//
//  About.swift
//  Created on 25/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack(spacing: DesignConstants.Form.Spacing.bigSpacing) {
            //logo image
            Image(ImageNameConstants.mentorshipLogoImageName)
                .resizable()
                .scaledToFit()
            
            //about text
            Text(LocalizableStringConstants.aboutText)
                .font(.body)
            
            //Spacer
            Spacer()
        }
        .padding()
        .navigationBarTitle("About", displayMode: .inline)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
