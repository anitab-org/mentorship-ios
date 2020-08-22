//
//  Config.swift
//  Created on 19/08/20
//  Created for AnitaB.org Mentorship-iOS 
//

import Foundation

struct ConfigValues {
    static func get() -> Config {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "plist") else {
            fatalError("Config.plist not found")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(Config.self, from: data)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

struct Config: Decodable {
    let googleAuthClientId: String
}
