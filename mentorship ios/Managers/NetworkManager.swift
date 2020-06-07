//
//  NetworkManager.swift
//  mentorship ios
//
//  Created by Yugantar Jain on 05/06/20.
//  Copyright © 2020 Yugantar Jain. All rights reserved.
//

import Foundation
import Combine

struct NetworkManager {
    static func callAPI<T: Decodable>(urlString: String, httpMethod: String, uploadData: Data, token: String = "") -> AnyPublisher<T, Error> {
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !token.isEmpty {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = httpMethod
        request.httpBody = uploadData
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
