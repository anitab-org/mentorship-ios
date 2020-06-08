//
//  AuthModel.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 08/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import Foundation
import Combine

final class AuthModel: ObservableObject {
    @Published var isLogged: Bool?
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = UserDefaults.standard
            .publisher(for: \.isLoggedIn)
            .sink {
                print($0)
                self.isLogged = $0
        }
    }
}
