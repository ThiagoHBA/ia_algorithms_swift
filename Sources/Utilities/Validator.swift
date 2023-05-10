//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation

/// Uitlity class used to validate the efficiency of a classifier who implements the protocol Classifier.
final class Validator {
    /**
        - Parameters:
          - classifier: The instance of a classifier who conforms to Classifier protocol.
          - testDataset: The array refering to dataset used to classify the data.
     
        - Returns: The efficiency of classifier using the following equation: (hits/expectedData)
     */
    static func validateClassifier(classifier: Classifier, testDataset: [Iris]) -> Double {
        classifier.train()
        var hits = 0
        
        for testInstance in testDataset {
            let expect = testInstance.species.rawValue
            let predict = classifier.predict(testInstance.vector!)
            if predict == expect { hits += 1 }
        }
        print("Hits: \(hits)")
        let percent = Double(CGFloat(hits)/CGFloat(testDataset.count))
        return percent
    }
}
