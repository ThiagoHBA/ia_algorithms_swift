//
//  File.swift
//  
//
//  Created by Thiago Henrique on 08/05/23.
//

import Foundation

struct Iris: Decodable {
    var id: Int
    var sepalLenght: Double
    var sepalWidth: Double
    var petalLenght: Double
    var petalWidth: Double
    let species: String
    var vector: SIMD4<Double>? {
        return SIMD4(sepalLenght, sepalWidth, petalLenght, petalWidth)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case sepalLenght = "SepalLengthCm"
        case sepalWidth = "SepalWidthCm"
        case petalLenght = "PetalLengthCm"
        case petalWidth = "PetalWidthCm"
        case species = "Species"
    }
    
    static func loadData() -> [Iris] {
        guard let url = Bundle.module.url(forResource: "Iris", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode([Iris].self, from: data)
            return json
        }
        catch {
            print(error)
        }
        return []
    }
}
