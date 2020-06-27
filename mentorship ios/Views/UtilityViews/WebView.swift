//
//  WebView.swift
//  Created on 25/06/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //convert string to url
        let url = URL(string: urlString)!
        //setup url request
        let request = URLRequest(url: url)
        //Load
        uiView.load(request)
    }
    
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.apple.com")
    }
}
