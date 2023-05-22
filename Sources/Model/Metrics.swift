//
//  File.swift
//  
//
//  Created by Thiago Henrique on 20/05/23.
//

import Foundation
import CreateML

struct Metrics {
    var confusionMatrix: [ConfusionMatrixValue]
    var classificationError: Double
    var evaluationMetrics: EvaluationMetrics
    var createMLMetrics: MLClassifierMetrics {
        return MLClassifierMetrics (
            classificationError: classificationError,
            confusion: try! MLDataTable(confusionMatrix: confusionMatrix),
            precisionRecall: try! MLDataTable(metrics: evaluationMetrics)
        )
    }
}
