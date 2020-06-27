//
//  About.swift
//  Created on 25/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI

struct About: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DesignConstants.Spacing.bigSpacing) {
                //logo image
                Image(ImageNameConstants.mentorshipLogoImageName)
                    .resizable()
                    .scaledToFit()
                
                //about text
                Text(LocalizableStringConstants.aboutText)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                
                //Links to privacy policy and terms of use.
                HStack(spacing: DesignConstants.Spacing.bigSpacing) {
                    //privacy policy
                    NavigationLink(
                        LocalizableStringConstants.privacyPolicy,
                        destination: WebView(urlString: URLStringConstants.WebsiteURLs.privacyPolicy))
                    
                    //terms of use
                    NavigationLink(
                        LocalizableStringConstants.termsOfUse,
                        destination: WebView(urlString: URLStringConstants.WebsiteURLs.termsOfUse))
                }
            }
        }
        .padding(.horizontal)
        .navigationBarTitle("About", displayMode: .inline)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
