import Foundation

class Day11 {
    typealias Input = [[Int]]
    func parse(input: String) -> Input {
        return input.split(separator: "\n").map { $0.map { Int(String($0))! } }
    }

    func partA(input: Input) -> Int {
        var sum = 0
        let size = input.count
        
        var a = input
        var b = input
//        var f = input
        for i in 0..<100 {
            //print("\(i)")
            
            var str = ""
            for x in 0..<size {
                for y in 0..<size {
                    str += "\(a[x][y])"
                }
                str += "\n"
            }
            //print(str)
            
            for x in 0..<size {
                for y in 0..<size {
                    a[x][y] += 1
                    b[x][y] = 0
//                    f[x][y] = 0
                }
            }
            
            var didFlash = true
            while didFlash {
                didFlash = false
                for x in 0..<size {
                    for y in 0..<size {
                        if a[x][y] > 9, b[x][y] == 0 {
                            sum += 1
                            a[x][y] = 0
                            b[x][y] = 1
                            didFlash = true
                            increment(map: &a, x: x-1, y: y-1)
                            increment(map: &a, x: x+0, y: y-1)
                            increment(map: &a, x: x+1, y: y-1)
                            increment(map: &a, x: x-1, y: y)
                            increment(map: &a, x: x+1, y: y)
                            increment(map: &a, x: x-1, y: y+1)
                            increment(map: &a, x: x+0, y: y+1)
                            increment(map: &a, x: x+1, y: y+1)
                        }
                    }
                }
            }
            for x in 0..<size {
                for y in 0..<size {
                    if b[x][y] == 1 {
                        a[x][y] = 0
                    }
                }
            }
        }
        
        return sum
    }
    
    func increment(map: inout Input, x: Int, y: Int) {
        if x >= 0, y >= 0, x<map.count, y<map.count {
            map[x][y] += 1
        }
    }
    
    func partB(input: Input) -> Int {
        var sum = 0
        let size = input.count
        
        var a = input
        var b = input
        for i in 0..<100000 {
            //print("\(i)")
            
            var str = ""
            for x in 0..<size {
                for y in 0..<size {
                    str += "\(a[x][y])"
                }
                str += "\n"
            }
            //print(str)
            
            for x in 0..<size {
                for y in 0..<size {
                    a[x][y] += 1
                    b[x][y] = 0
                }
            }
            
            var didFlash = true
            while didFlash {
                didFlash = false
                for x in 0..<size {
                    for y in 0..<size {
                        if a[x][y] > 9, b[x][y] == 0 {
                            sum += 1
                            a[x][y] = 0
                            b[x][y] = 1
                            didFlash = true
                            increment(map: &a, x: x-1, y: y-1)
                            increment(map: &a, x: x+0, y: y-1)
                            increment(map: &a, x: x+1, y: y-1)
                            increment(map: &a, x: x-1, y: y)
                            increment(map: &a, x: x+1, y: y)
                            increment(map: &a, x: x-1, y: y+1)
                            increment(map: &a, x: x+0, y: y+1)
                            increment(map: &a, x: x+1, y: y+1)
                        }
                    }
                }
            }
            var wasSynchornized = true
            for x in 0..<size {
                for y in 0..<size {
                    if b[x][y] == 1 {
                        a[x][y] = 0
                    } else {
                        wasSynchornized = false
                    }
                }
            }
            if wasSynchornized {
                return i + 1
            }
        }
        
        return sum
    }
}
