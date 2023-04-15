//
//  NetworkService.swift
//  Navigation
//
//  Created by Вадим Виноградов on 14.04.2023.
//

import Foundation

struct NetworkService {
    static func request(configuration: AppConfiguration ) {
        var url: URL
        switch configuration {
        case .people(let peopleURL):
            url = peopleURL
        case .starships(let starshipsURL):
            url = starshipsURL
        case .planets(let planetsURL):
            url = planetsURL
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {

                print("Error: \(error.localizedDescription)")
            } else {
                if let data = data {

                    let dataString = String(data: data, encoding: .utf8)
                    print("Data: \(dataString ?? "No data")")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    // print property .allHeaderFields и .statusCode у response
                    print("All Header Fields: \(httpResponse.allHeaderFields)")
                    print("Status Code: \(httpResponse.statusCode)")
                }
            }
        }
        
        task.resume()
    }
}

enum AppConfiguration {
    case people(URL)
    case starships(URL)
    case planets(URL)
}
