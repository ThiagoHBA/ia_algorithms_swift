//
//  File.swift
//  
//
//  Created by Thiago Henrique on 11/05/23.
//

import Foundation

/// Representation of weight data
typealias Weights = (w1: Double, w2: Double, w3: Double, w4: Double, w5: Double)
/// Define the rules of what a machine learning binary classifier should have.
protocol BinaryClassifier {
    /// Splited dataset divided by data used to train and test the model.
    var splitedDataset: ([Iris], [Iris]) { get }
    /// Weights used to predict values in classifier
    var weights: Weights { get }
    /// Calls the train implementation of classifier.
    func train()
    /**
     Calls the predict implementation of classifier.
      - Parameter testInstance: Value to being predict.
      - Returns: a String refering to class that has being predicted.
     */
    func predict(_ testInstace: SIMD4<Double>) ->  Int
    /// Activation funciton used to return a binary value
    func activationFunc(_ u: Double) -> Int
}
