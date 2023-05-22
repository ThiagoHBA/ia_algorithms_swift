//
//  File.swift
//  
//
//  Created by Thiago Henrique on 21/05/23.
//

import Foundation

struct EvaluationMetrics {
    let truePositive: Int
    let falsePositive: Int
    let falseNegative: Int
    
    var precision: Double {
        guard truePositive + falsePositive > 0 else { return 0 }
        return Double(truePositive) / Double(truePositive + falsePositive)
    }
    
    var recall: Double {
        guard truePositive + falseNegative > 0 else { return 0 }
        return Double(truePositive) / Double(truePositive + falseNegative)
    }
}
