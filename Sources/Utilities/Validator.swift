//
//  File.swift
//  
//
//  Created by Thiago Henrique on 09/05/23.
//

import Foundation

/// Uitlity class used to validate the efficiency of a classifier who implements the protocol Classifier.
final class Validator {
    let dataset: [Iris]
    
    init(_ dataset: [Iris]) { self.dataset = dataset }
    /**
        - Parameters:
          - classifier: The instance of a classifier who conforms to BinaryClassifier protocol.
          - testDataset: The array refering to dataset used to classify the data.
     
        - Returns: Metrics of inputed classifier
     */
    func generateMetrics(for classifier: BinaryClassifier, to specie: Specie) -> Metrics {
        var matrix: [ConfusionMatrixValue] = []
        var hits = 0
        var truePositive = 0
        var falsePositive = 0
        var falseNegative = 0
        
        classifier.train()
        for testInstance in dataset {
            let expected = testInstance.species == specie ? 1 : 0
            let result = classifier.predict(testInstance.vector!)
            
            if result == expected { hits += 1}
            
            if result == 1 && expected == 1 {
                truePositive += 1
            } else if result == 1 && expected != 1 {
                falsePositive += 1
            } else if result != 1 && expected == 1 {
                falseNegative += 1
            }

            if let dictIndex = matrix.firstIndex(
                where: {
                    $0.trueLabel == String(expected) &&
                    $0.predictedLabel == String(result)
                }
            ) {
                matrix[dictIndex].recurrence = "\(Int(matrix[dictIndex].recurrence)! + 1)"
                continue
            }

            matrix.append(
                ConfusionMatrixValue(
                    trueLabel: String(expected),
                    predictedLabel: String(result),
                    recurrence: "1"
                )
            )
        }
        return Metrics(
            confusionMatrix: matrix,
            classificationError: Double(hits)/Double(dataset.count),
            evaluationMetrics: EvaluationMetrics(
                truePositive: truePositive,
                falsePositive: falsePositive,
                falseNegative: falseNegative
            )
        )
    }
    /**
        - Parameters:
          - classifier: The instance of a classifier who conforms to Classifier protocol.
     
        - Returns: Metrics of inputed classifier
     */
    func generateMetrics(for classifier: Classifier, to specie: Specie) -> Metrics {
        var matrix: [ConfusionMatrixValue] = []
        var hits = 0
        var truePositive = 0
        var falsePositive = 0
        var falseNegative = 0
        
        classifier.train()
        for testInstance in dataset {
            let expected = testInstance.species.rawValue
            let result = classifier.predict(testInstance.vector!)
            
            if expected == result { hits += 1}
        
            if result == specie.rawValue && expected == specie.rawValue {
                truePositive += 1
            } else if result == specie.rawValue && expected != specie.rawValue {
                falsePositive += 1
            } else if result != specie.rawValue && expected == specie.rawValue {
                falseNegative += 1
            }

            if let dictIndex = matrix.firstIndex(
                where: {
                    $0.trueLabel == String(expected) &&
                    $0.predictedLabel == String(result)
                }
            ) {
                matrix[dictIndex].recurrence = "\(Int(matrix[dictIndex].recurrence)! + 1)"
                continue
            }

            matrix.append(
                ConfusionMatrixValue(
                    trueLabel: String(expected),
                    predictedLabel: String(result),
                    recurrence: "1"
                )
            )
        }
        return Metrics(
            confusionMatrix: matrix,
            classificationError: Double(hits)/Double(dataset.count),
            evaluationMetrics: EvaluationMetrics(
                truePositive: truePositive,
                falsePositive: falsePositive,
                falseNegative: falseNegative
            )
        )
    }
}
