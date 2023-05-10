//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation


/// Utility class to auxiliate in dataset operations.
final class DataUtility {
    /**
     Function  who split a generic dataset T in training and test arrays.
     - Parameters:
        - dataset: Current dataset to split
        - trainingFactor: The percent of splited data who will going to train array.
     */
    static func splitDataset<T>(_ dataset: [T],  trainingFactor: Double = 0.5) -> ([T], [T]) {
        var trainingData = [T]()
        var testData = [T]()
        let trainingLenght = Int(CGFloat(dataset.count) * trainingFactor)
        for i in 0..<trainingLenght { trainingData.append(dataset[i]) }
        for i in trainingLenght..<dataset.count { testData.append(dataset[i]) }
        return (trainingData, testData)
    }
}
