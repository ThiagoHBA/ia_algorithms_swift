import Foundation

let dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.8)
print("Training dataset lenght: \(dataset.0.count)")
print("Test dataset lenght: \(dataset.1.count)")
let knn = Knn(k: 3, splitedDataset: dataset)

print("Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %")
