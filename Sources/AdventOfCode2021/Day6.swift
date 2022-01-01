

import Foundation

struct Day6 {
    
    func multiply(input: [Int], days: Int) -> Int {
        
        var f: [Int] = Array.init(repeating: 0, count: 10)
        for i in input {
            f[i] += 1
        }
        
        for d in 0..<days {
            f[7] += f[0]
            f[9] = f[0]
            for i in 0..<9 {
                f[i] = f[i + 1]
            }

        }
        return f.reduce(0, +) - f[9]
    }
    
    
}
