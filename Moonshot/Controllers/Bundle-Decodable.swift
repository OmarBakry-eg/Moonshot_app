//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Omar Bakry on 12/12/2021.
//

import Foundation


extension Bundle {
    func decode<A: Codable>(_ file : String) -> A {
        guard let url : URL = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data : Data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        let decoder = JSONDecoder()
       let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loadedData :A = try? decoder.decode(A.self, from: data) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        return loadedData
    }
}
