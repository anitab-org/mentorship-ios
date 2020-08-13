//
//  AuthModel.swift
//  Created on 08/06/20.
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation
import Combine

final class AuthModel: ObservableObject {
    @Published var isLogged: Bool?
    private var cancellable: AnyCancellable?

    init() {
        //observe login state
        cancellable = UserDefaults.standard
            .publisher(for: \.isLoggedIn)
            .sink {
                self.isLogged = $0
        }
    }
}
