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
        URLCache.shared = URLCache.init(memoryCapacity: 50*1024*1024, diskCapacity: 200*1024*1024, diskPath: nil)

        cancellable = UserDefaults.standard
            .publisher(for: \.isLoggedIn)
            .sink {
                print($0)
                self.isLogged = $0
        }
    }
}
