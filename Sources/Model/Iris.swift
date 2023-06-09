//
//  File.swift
//  
//
//  Created by Thiago Henrique on 08/05/23.
//

import Foundation

/// Data Object refering to Iris dataset.
struct Iris: Decodable, Equatable {
    var id: Int
    var sepalLenght: Double
    var sepalWidth: Double
    var petalLenght: Double
    var petalWidth: Double
    let species: Specie
    /// SIMD (Single Instruct Multiple Data) containing all atributes used to predict a Iris species.
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
    
    /**
        Function used to load the dataset JSON data.
      - Returns: Decoded array of Iris refering to the dataset.
     */
    static func loadData() -> [Iris] {
        guard let url = Bundle.module.url(forResource: "Iris", withExtension: "json") else { return [] }
        do {
            let binaryData = try Data(contentsOf: url)
            var irisData = try JSONDecoder().decode([Iris].self, from: binaryData)
            irisData.shuffle() // Using shuffle everytime, in theory, this will return a new dataset
            return irisData
        }
        catch {
            print(error)
        }
        return []
    }
    
    /// Convert in Iris object using as start point a SIMD structure.
    static func fromSimd(id: Int, simd: SIMD4<Double>, species: String) -> Iris {
        return Iris(
            id: id,
            sepalLenght: simd.x,
            sepalWidth: simd.y,
            petalLenght: simd.z,
            petalWidth: simd.w,
            species: Specie(rawValue: species)!
        )
    }
}
