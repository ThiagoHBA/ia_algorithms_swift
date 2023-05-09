//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation

final class DataUtility {
    static func splitDataset<T>(_ dataset: [T],  trainingFactor: Double = 0.5) -> ([T], [T]) {
        var trainingData = [T]()
        var testData = [T]()
        let trainingLenght = Int(CGFloat(dataset.count) * trainingFactor)
        for i in 0..<trainingLenght { trainingData.append(dataset[i]) }
        for i in trainingLenght..<dataset.count { testData.append(dataset[i]) }
        return (trainingData, testData)
    }
}
