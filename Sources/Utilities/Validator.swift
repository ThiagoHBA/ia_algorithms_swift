//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation

class Validator {
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
