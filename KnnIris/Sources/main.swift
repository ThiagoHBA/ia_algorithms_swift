import Foundation

struct Iris {
    var id: Int
    var sepalLenght: Double
    var sepalWidth: Double
    var petalLenght: Double
    var petalWidth: Double
    let species: String
}

class Knn {
    @available(macOS 13.0, *)
    func readCSV() -> [Iris] {
        var irisArray: [Iris] = [Iris]()
        do {
            let docUrl = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
            let url: URL = URL(filePath: "Code/KnnIris/Resource/Iris.csv", relativeTo: docUrl)
            let data = try String(contentsOf: url)
            
            let rows = data.components(separatedBy: "\n")
            let validRows = rows[1..<rows.count]
            
            for element in validRows {
                let column = element.components(separatedBy: ",")
                if let id = Int(column[0]),
                   let sepalLenght = Double(column[1]),
                   let sepalWidth = Double(column[2]),
                   let petalLength = Double(column[3]),
                   let petalwidth = Double(column[4]) {
                    
                    let iris = Iris(
                        id: id,
                        sepalLenght: sepalLenght,
                        sepalWidth: sepalWidth,
                        petalLenght: petalLength,
                        petalWidth: petalwidth,
                        species: column[5]
                    )
                    irisArray.append(iris)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return irisArray
    }
    
    func adaptClass(type: String) -> Int {
        switch type {
        case "Iris-setosa":
            return 0
        case "Iris-Virginica":
            return 2
        default:
            return 1
        }
    }
}

func split(x: [Iris], y: [Int], trainSize: Double) -> ([Iris], [Int], [Iris], [Int]) {
    var trainX = [Iris]()
    var trainY = [Int]()
    var testX = [Iris]()
    var testY = [Int]()
    let trainCount = Int((CGFloat(x.count) * trainSize))
    
    for i in 0..<trainCount {
        trainX.append(x[i])
        trainY.append(y[i])
    }
    
    for i in trainCount..<x.count {
        testX.append(x[i])
        testY.append(y[i])
    }
    
    return (trainX, trainY, testX, testY)
}

if #available(macOS 13.0, *) {
    let knn = Knn()
    let x = knn.readCSV()
    var y: [Int] = []
    
    for val in x { y.append(knn.adaptClass(type: val.species)) }
    
    let splitedData = split(x: x, y: y, trainSize: 0.9)
    let xTrain = splitedData.0
    let yTrain = splitedData.1
    let xTest = splitedData.2
    let yTest = splitedData.3
    
}
