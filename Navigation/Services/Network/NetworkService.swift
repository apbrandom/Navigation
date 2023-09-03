//
//  NetworkService.swift
//  Navigation
//
//  Created by Вадим Виноградов on 14.04.2023.
//

import Foundation

class NetworkService {
    
    let group = DispatchGroup()
    
    func urlForUser(withId: Int) -> URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/todos/\(withId)")
    }
    
    func urlPlanetInstance() -> URL? {
        return URL(string: "https://swapi.dev/api/planets/1")
    }
    
    func request(url: URL, completion: @escaping (String?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let title = jsonObject["title"] as? String {
                                let jsonData = JsonData(title: title)
                                completion(jsonData.title)
                            } else {
                                print("Title not found in JSON object")
                                completion(nil)
                            }
                            
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
    
    func requestPlanetData(completion: @escaping (Planet?) -> Void) {
        guard let url = urlPlanetInstance() else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let planetData = try decoder.decode(Planet.self, from: data)
            
                    completion(planetData)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    //Task #3
    func fetchResidentData(url: URL, completion: @escaping (Resident?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let residentData = try decoder.decode(Resident.self, from: data)
                    completion(residentData)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }

    func fetchResidents(for planet: Planet, completion: @escaping ([Resident]?) -> Void) {
        var residents = [Resident]()
        
        for url in planet.residents {
            group.enter()
            fetchResidentData(url: url) { resident in
                if let resident = resident {
                    residents.append(resident)
                }
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(residents)
        }
    }
}
