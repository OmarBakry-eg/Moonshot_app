//
//  Astronauts Model.swift
//  Moonshot
//
//  Created by Omar Bakry on 12/12/2021.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
