import Foundation
import CoreML

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
//print("Perceptron: ")
//let expectedSpecie: Specie = .IrisVersicolor
//let perceptron = Perceptron(dataset: dataset, expectedSpecie: expectedSpecie, ephocs: 200)
//print("Percent: \(Validator.validateClassifier(classifier: perceptron, testDataset: dataset.1, expectedClass: expectedSpecie)) %\n")

// MARK: - Percepton CoreML
let perceptron = Perceptron(dataset: dataset, expectedSpecie: .IrisSetosa)
perceptron.train()

let modelDescription = MLModelDescription()
let coreMLPerceptron = try CoreMLAdapter(modelDescription: modelDescription, parameters: ["classifier": perceptron])

for testInstance in dataset.1 {
    let expected = testInstance.species == Specie.IrisSetosa
    let result = try coreMLPerceptron.prediction(from: IrisInput(vector: testInstance.vector!), options: MLPredictionOptions())
    print("Expected: \(expected) ; Predicted: \(result.featureValue(for: "output")!)")
}


