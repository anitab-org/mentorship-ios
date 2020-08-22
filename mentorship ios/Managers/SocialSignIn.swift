//
//  GoogleSignInButton.swift
//  Created on 09/08/20
//  Created for AnitaB.org Mentorship-iOS 
//

import SwiftUI
import GoogleSignIn
import AuthenticationServices

struct SocialSignIn: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<SocialSignIn>) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SocialSignIn>) {
    }
    
    // show google sign in flow
    func attemptSignInGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    // make network request to callback url after recieivng user's data from provider
    static func makeNetworkRequest(loginService: LoginService, loginViewModel: LoginViewModel, idToken: String, name: String, email: String, signInType: LoginModel.SocialSignInType) {
        loginViewModel.inActivity = true
        loginService.socialSignInCallback(
            socialSignInData: .init(idToken: idToken, name: name, email: email),
            socialSignInType: signInType) { response in
                loginViewModel.update(using: response)
                loginViewModel.inActivity = false
        }
    }
}

// Used in login view model
class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate {
    var loginService: LoginService
    var loginViewModel: LoginViewModel
    
    init(loginService: LoginService = LoginAPI(), loginVM: LoginViewModel) {
        self.loginViewModel = loginVM
        self.loginService = loginService
    }
    
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    // Delegate methods
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Get user details
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email ?? ""
            let name = (fullName?.givenName ?? "") + (" ") + (fullName?.familyName ?? "")
            
            // Make network request to backend
            SocialSignIn.makeNetworkRequest(loginService: loginService, loginViewModel: loginViewModel, idToken: userIdentifier, name: name, email: email, signInType: .apple)
            
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
