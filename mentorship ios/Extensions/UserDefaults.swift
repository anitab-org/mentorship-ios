//
// UserDefaults.swift
// Created on 08/06/20.
// Created for AnitaB.org Mentorship-iOS
//

import Foundation

extension UserDefaults {
    @objc dynamic var isLoggedIn: Bool {
        return bool(forKey: UserDefaultsConstants.isLoggedIn)
    }
}
