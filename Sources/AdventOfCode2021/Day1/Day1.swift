import Foundation

class Day1 {
    func countIncrease(d: [Int]) -> Int {
        var previous = d[0]
        var count = 0
        for measurement in d {
            if measurement > previous {
                count += 1
            }
            previous = measurement
        }
        return count
    }

    func countIncreaseSlidingWindow(d: [Int]) -> Int {
        var windowed: [Int] = []
        for i in 0..<(d.count - 2) {
            windowed += [d[i] + d[i + 1] + d[i + 2]]
        }
        var previous = windowed[0]
        var count = 0
        for measurement in windowed {
            //print(measurement)
            if measurement > previous {
                count += 1
            }
            previous = measurement
        }
        return count
    }
}
