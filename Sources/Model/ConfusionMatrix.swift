//
//  File.swift
//  
//
//  Created by Thiago Henrique on 18/05/23.
//

import Foundation
import CreateML

struct ConfusionMatrixValue: Encodable {
    let trueLabel: String
    let predictedLabel: String
    var recurrence: String
}
