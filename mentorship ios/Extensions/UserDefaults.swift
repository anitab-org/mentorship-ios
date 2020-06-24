//
// UserDefaults.swift
// Created on 08/06/20.
// Created for AnitaB.org Mentorship-iOS
//

import Foundation

extension UserDefaults {
    //used to do KVO using Combine
    //observed for login state, login or home screen showed accordingly.
    //Used in ContentView.swift
    @objc dynamic var isLoggedIn: Bool {
        return bool(forKey: UserDefaultsConstants.isLoggedIn)
    }
}
