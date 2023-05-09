import Foundation

let dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.6)
let knn = Knn(k: 3, splitedDataset: dataset)

print("Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %")
