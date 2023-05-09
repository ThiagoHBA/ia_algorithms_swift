import Foundation

let dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.7)
print("Training dataset lenght: \(dataset.0.count)")
print("Test dataset lenght: \(dataset.1.count)")

// MARK: - KNN
print("KNN: ")
let knn = KNN(k: 3, splitedDataset: dataset)
print("Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %\n")

// MARK: - DMC
print("DMC: ")
let dmc = DMC(splitedDataset: dataset)
print("Percent: \(Validator.validateClassifier(classifier: dmc, testDataset: dataset.1)) %\n")
