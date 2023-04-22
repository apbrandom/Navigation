//
//  NetworkService.swift
//  Navigation
//
//  Created by Вадим Виноградов on 14.04.2023.
//

import Foundation

struct NetworkService {
    static func randomURL() -> URL? {
        let urlStrings = [
            "https://swapi.dev/api/people/8",
            "https://swapi.dev/api/starships/3",
            "https://swapi.dev/api/planets/5"
        ]

        let urlString = urlStrings.randomElement()

        return urlString.flatMap { URL(string: $0) }
    }
    
    static func request(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                
                if let data = data {
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data: \(dataString ?? "No data")")
                }
                
                // print property .allHeaderFields and .statusCode response
                if let httpResponse = response as? HTTPURLResponse {
                    print("All Header Fields: \(httpResponse.allHeaderFields)")
                    print("Status Code: \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
}
