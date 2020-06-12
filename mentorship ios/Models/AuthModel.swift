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
        cancellable = UserDefaults.standard
            .publisher(for: \.isLoggedIn)
            .sink {
                print($0)
                self.isLogged = $0
        }
    }
}
