//
//  File.swift
//  
//
//  Created by Thiago Henrique on 11/05/23.
//

import Foundation

/// Define the rules of what a machine learning binary classifier should have.
protocol BinaryClassifier {
    /// Splited dataset divided by data used to train and test the model.
    var splitedDataset: ([Iris], [Iris]) { get }
    /// Calls the train implementation of classifier.
    func train()
    /**
     Calls the predict implementation of classifier.
      - Parameter testInstance: Value to being predict.
      - Returns: a String refering to class that has being predicted.
     */
    func predict(_ testInstace: SIMD4<Double>) ->  Int
}
