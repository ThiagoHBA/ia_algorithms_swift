//
//  File.swift
//  
//
//  Created by Thiago Henrique on 08/05/23.
//

import Foundation
import simd

class KNN: Classifier {
    var splitedDataset: ([Iris], [Iris])
    private(set) var trainingData: [Iris] = [Iris]()
    var k: Int
    
    init(k: Int, splitedDataset: ([Iris], [Iris])) {
        self.k = k
        self.splitedDataset = splitedDataset
    }
    
    func train() {  for trainingElement in splitedDataset.0 { trainingData.append(trainingElement) } }
    
    func predict(_ testInstance: SIMD4<Double>) -> String {
        var distances: [(Iris, Double)] = []
        
        for i in 0..<trainingData.count {
            let distance = simd_distance(testInstance, trainingData[i].vector!)
            distances.append((trainingData[i], distance))
        }
        
        distances = distances.sorted(by: { $0.1 < $1.1 })

        var neighbors: [Iris] = []
        for i in 0..<k { neighbors.append(distances[i].0) }
        
        let countSpecies = [
            "Iris-setosa": neighbors.filter { $0.species.rawValue == "Iris-setosa"}.count,
            "Iris-versicolor": neighbors.filter { $0.species.rawValue == "Iris-versicolor"}.count,
            "Iris-virginica": neighbors.filter { $0.species.rawValue == "Iris-virginica"}.count
        ]
        
        return countSpecies.sorted(by: { $0.value > $1.value } ).first!.key
    }
}
