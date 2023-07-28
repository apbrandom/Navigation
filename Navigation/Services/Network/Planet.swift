//
//  PlanetData.swift
//  Navigation
//
//  Created by Вадим Виноградов on 09.06.2023.
//

import Foundation

 struct Planet: Decodable {
    let name: String
    let orbitalPeriod: String
    let residents: [URL]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case residents
    }
}

struct Resident: Decodable {
    let name: String
}
