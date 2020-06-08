//
//  UserDefaults.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 08/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import Foundation

extension UserDefaults {
    @objc dynamic var isLoggedIn: Bool {
        return bool(forKey: "isLoggedIn")
    }
}
