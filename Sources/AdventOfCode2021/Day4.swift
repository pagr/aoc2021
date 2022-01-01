struct Day4 {
    typealias Data = (numbers: [Int], matrices: [[[Int]]])
    func parse(input: String) -> Data {
        let numbers = input
            .split(separator: "\n")[0]
            .split(separator: ",")
            .map { Int($0)! }
        let matrices = input
            .components(separatedBy: "\n\n")
            .dropFirst()
            .map {
                $0.split(separator: "\n").map {
                    $0.split(separator: " ").map { Int($0)! }
                }
            }
        return (numbers, matrices)
    }
    
    func bingoFirst(data: Data) -> Int {
        let (numbers, matrices) = data
        var testMatrix = matrices.map { _ in Array(repeating: Array(repeating: false, count: 5), count: 5) }

        for number in numbers {
            for (i, matrix) in matrices.enumerated() {
                guard let (x, y) = getIndex(of: number, in: matrix) else { continue }
                testMatrix[i][x][y] = true

                if isBingo(testMatrix: testMatrix[i]) {
                    var sum: Int = 0
                    for x in 0..<5 {
                        for y in 0..<5 {
                            sum += testMatrix[i][x][y] ? 0 : matrix[x][y]
                        }
                    }
                    //printMatrix(testMatrix[i])
                    //printMatrix(matrix)
                    return sum * number
                }
            }
        }
        fatalError()
    }

    func bingoLast(data: Data) -> Int {
        let (numbers, matrices) = data
        var testMatrix = matrices.map { _ in Array(repeating: Array(repeating: false, count: 5), count: 5) }
        var ignoredBoards: [Int] = []
        for number in numbers {
            for (i, matrix) in matrices.enumerated() {
                guard !ignoredBoards.contains(i) else { continue }
                guard let (x, y) = getIndex(of: number, in: matrix) else { continue }
                testMatrix[i][x][y] = true

                if isBingo(testMatrix: testMatrix[i]) {
                    if ignoredBoards.count == matrices.count - 1 {
                        var sum: Int = 0
                        for x in 0..<5 {
                            for y in 0..<5 {
                                sum += testMatrix[i][x][y] ? 0 : matrix[x][y]
                            }
                        }
                        //printMatrix(testMatrix[i])
                        //printMatrix(matrix)
                        return sum * number
                    } else {
                        ignoredBoards += [i]
                    }
                }
            }
        }
        fatalError()
    }

    func getIndex(of number: Int, in matrix: [[Int]]) -> (x: Int, y: Int)? {
        for x in 0..<5 {
            for y in 0..<5 {
                if matrix[x][y] == number {
                    return (x, y)
                }
            }
        }
        return nil
    }

    func isBingo(testMatrix: [[Bool]]) -> Bool {
        return testMatrix
            .map { $0.reduce(true) { $0 && $1 } }
            .contains(true) ||
            testMatrix
            .transposed()
            .map { $0.reduce(true) { $0 && $1 } }
            .contains(true)
    }

    func printMatrix<T>(_ matrix: [[T]]) {
        var result: String = ""
        for x in 0..<5 {
            for y in 0..<5 {
                result += "\(matrix[x][y]) "
            }
            result += "\n"
        }
        print(result)
    }
}

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    // PRECONDITION: `self` must be rectangular, i.e. every row has equal size.
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}
