import Foundation
import CoreML
import CreateML

let dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.7)
let validator = Validator(dataset.1)
print("Training dataset lenght: \(dataset.0.count)")
print("Test dataset lenght: \(dataset.1.count)")

// MARK: - KNN
//print("KNN: ")
//let knn = KNN(k: 3, splitedDataset: dataset)
//print("Percent: \(validator.generateMetrics(for: knn).classificationError) %\n")

// MARK: - DMC
//print("DMC: ")
//let dmc = DMC(splitedDataset: dataset)
//print("Percent: \(validator.generateMetrics(for: dmc).classificationError) %\n")

// MARK: - Percepton
//print("Perceptron: ")
//let expectedSpecie: Specie = .IrisVersicolor
//let perceptron = Perceptron(dataset: dataset, expectedSpecie: expectedSpecie, ephocs: 200)
//print("Percent: \(validator.generateMetrics(for: perceptron).classificationError) %\n")

// MARK: - Percepton CoreML
//let perceptron = Perceptron(dataset: dataset, expectedSpecie: .IrisSetosa)
//perceptron.train()
//
//let modelDescription = MLModelDescription()
//let coreMLPerceptron = try CoreMLAdapter(modelDescription: modelDescription, parameters: ["classifier": perceptron])

// MARK: - Percepton CreateML metrics
let specie: Specie = .IrisSetosa
let perceptron = Perceptron(dataset: dataset, expectedSpecie: specie)
let metrics = validator.generateMetrics(for: perceptron, to: specie)
