//
//  File.swift
//  
//
//  Created by Thiago Henrique on 08/05/23.
//

import Foundation

protocol Classifier {
    func train()
    func predict(_ testInstace: SIMD4<Double>) -> String
}
