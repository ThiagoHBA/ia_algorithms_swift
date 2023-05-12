import Foundation

let dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.7)
print("Training dataset lenght: \(dataset.0.count)")
print("Test dataset lenght: \(dataset.1.count)")

// MARK: - KNN
//print("KNN: ")
//let knn = KNN(k: 3, splitedDataset: dataset)
//print("Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %\n")

// MARK: - DMC
//print("DMC: ")
//let dmc = DMC(splitedDataset: dataset)
//print("Percent: \(Validator.validateClassifier(classifier: dmc, testDataset: dataset.1)) %\n")

// MARK: - Percepton
print("Perceptron: ")
let expectedSpecie: Specie = .IrisVirginica
let perceptron = Perceptron(dataset: dataset, expectedSpecie: expectedSpecie, ephocs: 200)
print("Percent: \(Validator.validateClassifier(classifier: perceptron, testDataset: dataset.1, expectedClass: expectedSpecie)) %\n")
