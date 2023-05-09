//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation
import simd

class DMC: Classifier {
    private(set) var trainingData: [Iris] = [Iris]()
    private(set) var splitedDataset: ([Iris], [Iris])
    
    required init(splitedDataset: ([Iris], [Iris])) {
        self.splitedDataset = splitedDataset
    }
    
    func train() {
        for (index, specie) in Specie.allCases.enumerated() {
            let filteredArray = splitedDataset.0.filter { $0.species == specie}
            let data = filteredArray.reduce(SIMD4()) { partialResult, value in
                return partialResult + value.vector!
            }
            trainingData.append(
                Iris.fromSimd(
                    id: index,
                    simd: data / Double(filteredArray.count),
                    species: specie.rawValue
                )
            )
        }
    }
    
    func predict(_ testInstance: SIMD4<Double>) -> String {
        var distances: [(Iris, Double)] = []
        
        for i in 0..<trainingData.count {
            let distance = simd_distance(testInstance, trainingData[i].vector!)
            distances.append((trainingData[i], distance))
        }
        
        distances = distances.sorted(by: { $0.1 < $1.1 })
        return distances.first!.0.species.rawValue
    }
    
}
