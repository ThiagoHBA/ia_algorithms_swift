//
//  File.swift
//  
//
//  Created by Thiago Henrique on 16/05/23.
//

import Foundation
import CoreML

/// CoreMLAdapter class used to adapt a BinaryClassifier model to a CoreML custom model.
@objc(Perceptron)
class CoreMLAdapter: NSObject, MLCustomModel {
    var classifier: BinaryClassifier
    
    required init(modelDescription: MLModelDescription, parameters: [String : Any]) throws {
        self.classifier = parameters["classifier"] as! any BinaryClassifier
        super.init()
    }
    
    func prediction(from input: MLFeatureProvider, options: MLPredictionOptions = MLPredictionOptions()) throws -> MLFeatureProvider {
        guard let inputInstance = input.featureValue(for: "vector")?.multiArrayValue else { return IrisOutput(output: 0)}
        let vector = SIMD4<Double>(
            Double(truncating: inputInstance[0]),
            Double(truncating: inputInstance[1]),
            Double(truncating: inputInstance[2]),
            Double(truncating: inputInstance[3])
        )
        return IrisOutput(output: classifier.predict(vector))
    }
}

/// Representation of expected features who are used to input values on prediction
final class IrisInput: MLFeatureProvider {
    let vector: SIMD4<Double>
    
    init(vector: SIMD4<Double>) { self.vector = vector }
    
    var featureNames: Set<String> { get { return ["vector"] } }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if featureName == "vector" {
            if #available(macOS 12.0, *) {
                return MLFeatureValue(shapedArray: [vector.x, vector.y, vector.z, vector.w])
            }
        }
        return nil
    }
}

/// Representation of expected features who are used when the classifier return a prediction
final class IrisOutput: MLFeatureProvider {
    let output: Int
    
    init(output: Int) {
        self.output = output
    }
    
    var featureNames: Set<String> { get { return ["output"] } }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if featureName == "output" {
            return MLFeatureValue(int64: Int64(output))
        }
        return nil
    }
}


