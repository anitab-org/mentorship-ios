////
////  KeyboardManager.swift
////  mentorship ios
////
////  Created by Yugantar Jain on 09/06/20.
////  Copyright © 2020 Yugantar Jain. All rights reserved.
////
//
//import Foundation
//import Combine
//import SwiftUI
//
//final class KeyboardManager: ObservableObject {
//    @Published var keyboardHeight: CGFloat = 0
//
//    func observeKeyboardHeight() {
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
//            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//            self.keyboardHeight = value.height
//        }
//
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {_ in
//            self.keyboardHeight = 0
//        }
//    }
//
//}
