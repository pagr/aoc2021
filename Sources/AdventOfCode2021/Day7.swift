import Foundation

struct Day7 {
    func parse(input: String) -> [Int] {
        input.split(separator: ",").map { Int($0)! }
    }
    
    func findBest(positions: [Int]) -> Int {
        var bestScore: Int = Int.max
        for i in 0..<1000 {
            var score = 0
            for pos in positions {
                score += abs(pos - i)
            }
            if score < bestScore {
                bestScore = score
            }
        }
        
        return bestScore
    }
    
    func findBest2(positions: [Int]) -> Int {
        var bestScore: Int = Int.max
        for i in 0..<1000 {
            var score = 0
            for pos in positions {
                let n = abs(pos - i)
                score += n * (1 + n) / 2
            }
            if score < bestScore {
                bestScore = score
            }
        }
        
        return bestScore
    }
}
