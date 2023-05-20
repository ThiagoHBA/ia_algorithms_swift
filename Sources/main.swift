import Foundation
import CoreML
import CreateML

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
//let expectedSpecie: Specie = .IrisSetosa
//let perceptron = Perceptron(dataset: dataset, expectedSpecie: expectedSpecie, ephocs: 200)
//print("Percent: \(Validator.validateClassifier(classifier: perceptron, testDataset: dataset.1, expectedClass: expectedSpecie)) %\n")

// MARK: - Percepton CoreML/CreateML - WIP
let perceptron = Perceptron(dataset: dataset, expectedSpecie: .IrisSetosa)
perceptron.train()

let modelDescription = MLModelDescription()
let coreMLPerceptron = try CoreMLAdapter(modelDescription: modelDescription, parameters: ["classifier": perceptron])

var hits = 0.0
var confusionMatrix: [ConfusionMatrixValue] = []

for testInstance in dataset.1 {
    let expected = testInstance.species == Specie.IrisSetosa
    let result = try coreMLPerceptron.prediction(from: IrisInput(vector: testInstance.vector!)).featureValue(for: "output")!.int64Value == 1

    if expected == result { hits += 1 }

    if let dictIndex = confusionMatrix.firstIndex(
        where: {
            $0.trueLabel == String(expected) &&
            $0.predictedLabel == String(result)
        }
    ) {
        confusionMatrix[dictIndex].recurrence = "\(Int(confusionMatrix[dictIndex].recurrence)! + 1)"
        continue
    }

    confusionMatrix.append(
        ConfusionMatrixValue(
            trueLabel: String(expected),
            predictedLabel: String(result),
            recurrence: "1"
        )
    )
}

print("hits: \(hits)")

var classificationError = hits/Double(dataset.1.count)
let matrixEnconded = try JSONEncoder().encode(confusionMatrix)
var arrayDict = try JSONSerialization.jsonObject(with: matrixEnconded) as! [[String: String]]
var mlDict: [String: [MLString]] = .init()

for dict in arrayDict {
    dict.forEach { tuple in
        let (key, value) = tuple
        if mlDict[key] != nil {
            mlDict[key]?.append(MLString(value))
        } else {
            mlDict[key] = [MLString(value)]
        }
    }
}

let dataTable = try MLDataTable(dictionary: mlDict)

//let metrics = MLClassifierMetrics(
//    classificationError: classificationError,
//    confusion: dataTable,
//    precisionRecall:
//)

struct MLString: MLDataValueConvertible {

    var value: String

    public static var dataValueType: MLDataValue.ValueType {
        .string
    }

    public init?(from dataValue: MLDataValue) {
        switch dataValue {
        case .string(let string):
            self.value = string
        default:
            return nil
        }
    }

    public init() {
        self.value = ""
    }


    init(_ string: String) {
        self.value = string
    }

    public var dataValue: MLDataValue {
        .string(value)
    }

    public func unsafeToInt() -> Int {
        Int(self.value)!
    }

    public func unsafeToBool() -> Bool {
        Bool(self.value)!
    }
}

/*
 {
    "A": [6, 4],
    "B": [0, 10]
 }
 */

