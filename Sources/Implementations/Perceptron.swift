//
//  File.swift
//  
//
//  Created by Thiago Henrique on 11/05/23.
//

import Foundation

typealias Weights = (w1: Double, w2: Double, w3: Double, w4: Double, w5: Double)
typealias PerceptronInputs = (Double, Double, Double, Double, Double)

class Perceptron: BinaryClassifier {
    var splitedDataset: ([Iris], [Iris])
    var expectedSpecie: Specie
    var weights: Weights
    var ephocs: Int
    var learningRate: Double
    
    init(
        dataset: ([Iris], [Iris]),
        expectedSpecie: Specie,
        ephocs: Int = 100,
        learningRate: Double = 0.1
    ) {
        self.splitedDataset = dataset
        self.expectedSpecie = expectedSpecie
        self.ephocs = ephocs
        self.learningRate = learningRate
        self.weights = (
            w1: Double.random(in: -1...1),
            w2: Double.random(in: -1...1),
            w3: Double.random(in: -1...1),
            w4: Double.random(in: -1...1),
            w5: Double.random(in: -1...1)
        )
    }
    
    func train() {
        for _ in 0..<ephocs {
            for item in splitedDataset.0 {
                let label = item.species == expectedSpecie ? 1 : 0
                guard let vector = item.vector else { return }
              
                let output = predict(vector)
                let error = Double(label - output)
                
                weights.w1 += learningRate * error * -1
                weights.w2 += learningRate * error * vector.x
                weights.w3 += learningRate * error * vector.y
                weights.w4 += learningRate * error * vector.z
                weights.w5 += learningRate * error * vector.w
            }
        }
    }
    
    func predict(_ testInstance: SIMD4<Double>) -> Int {
        let i1 = -1 * weights.w1
        let i2 = testInstance.x * weights.w2
        let i3 = testInstance.y * weights.w3
        let i4 = testInstance.z * weights.w4
        let i5 = testInstance.w * weights.w5
        
        let u = i1 + i2 + i3 + i4 + i5
        let output = activationFunc(u)
        return output
    }
    
    private func activationFunc(_ u: Double) -> Int { return u >= 0.0 ? 1 : 0 }
}
