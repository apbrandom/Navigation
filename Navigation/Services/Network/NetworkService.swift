//
//  NetworkService.swift
//  Navigation
//
//  Created by Вадим Виноградов on 14.04.2023.
//

import Foundation

struct JsonData: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class NetworkService {
    
    //Create random URL
    func randomURL() -> URL? {
        let urlStrings = [
            "https://swapi.dev/api/people/8",
            "https://swapi.dev/api/starships/3",
            "https://swapi.dev/api/planets/5"
        ]
        
        let urlString = urlStrings.randomElement()
        
        return urlString.flatMap { URL(string: $0) }
    }
    
    func request(url: URL, completion: @escaping (String?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let answer = try JSONDecoder().decode(JsonData.self, from: data)
                            completion(answer.title)
                        } catch {
                            print("Decoding error: \(error)")
                            completion(nil)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    func urlForUser(withId: Int) -> URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/todos/\(withId)")
    }
}
