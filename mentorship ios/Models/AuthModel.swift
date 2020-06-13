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
        //increase cache capacity
        URLCache.shared = URLCache(memoryCapacity: 50*1024*1024, diskCapacity: 200*1024*1024, diskPath: nil)

        //observe login state
        cancellable = UserDefaults.standard
            .publisher(for: \.isLoggedIn)
            .sink {
                self.isLogged = $0
        }
    }
}
