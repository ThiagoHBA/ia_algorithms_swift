//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/05/23.
//

import Foundation
import CreateML

extension MLDataTable {
    init(confusionMatrix: [ConfusionMatrixValue]) throws {
        let matrixEnconded = try JSONEncoder().encode(confusionMatrix)
        let arrayDict = try JSONSerialization.jsonObject(with: matrixEnconded) as! [[String: String]]
        var mlDict: [String: [MLString]] = .init()
        
        for dict in arrayDict {
            dict.forEach { tuple in
                let (key, value) = tuple
                if mlDict[key] != nil {
                    mlDict[key]?.append(MLString(value))
                } else {
                    mlDict[key] = [MLString(value)]
                }
            }
        }
        
        try self.init(dictionary: mlDict)
    }
    
    init(metrics: EvaluationMetrics) throws {
        try self.init(dictionary: [
            "TruePositive": [metrics.truePositive],
            "FalsePositive": [metrics.falsePositive],
            "FalseNegative": [metrics.falseNegative],
            "Precision": [metrics.precision],
            "Recall": [metrics.recall]
        ])
    }
}

struct MLString: MLDataValueConvertible {
    var value: String
    
    public static var dataValueType: MLDataValue.ValueType { .string }
    
    public init?(from dataValue: MLDataValue) {
        switch dataValue {
        case .string(let string):
            self.value = string
        default:
            return nil
        }
    }
    
    public init() { self.value = "" }
    
    init(_ string: String) { self.value = string }
    
    public var dataValue: MLDataValue { .string(value) }
    
    public func unsafeToInt() -> Int { Int(self.value)! }
    
    public func unsafeToBool() -> Bool { Bool(self.value)! }
}
