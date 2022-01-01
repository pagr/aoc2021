import Foundation

class Day15 {
    typealias Input = [[Int]]
    typealias Position = Day9.Position

    struct PositionWithScore: Hashable {
        let x, y, s: Int
    }

    func parse(input: String) -> Input {
        input.components(separatedBy: "\n").map {
            $0.map { Int("\($0)")! }
        }
    }

    func partA(input map: Input) -> Int {
        pathFind(map: map)
    }

    func pathFind(map: Input) -> Int {
        let w = map.count
        let h = map[0].count
        var open: Set<PositionWithScore> = [PositionWithScore(x: 0, y: 0, s: 0)]
        var closed: Set<Position> = [Position(x: 0, y: 0)]
        let target = Position(x: w - 1, y: h - 1)

        while let next = open.min(by: { $0.s < $1.s }) {
            open.remove(next)
            let s = next.s
            let x = next.x
            let y = next.y
            for n in [Position(x: x + 1, y: y), Position(x: x - 1, y: y),
                      Position(x: x, y: y + 1), Position(x: x, y: y - 1)]
            {
                guard n.x >= 0, n.y >= 0, n.x < w, n.y < h else { continue }
                guard !closed.contains(n) else { continue }
                if n == target {
                    return s + map[n.y][n.x]
                }
                open.insert(PositionWithScore(x: n.x, y: n.y, s: s + map[n.y][n.x]))
                closed.insert(n)
            }
        }
        return 0
    }

    func partB(input: Input) -> Int {
        let map = createLargeMap(input: input)
        return pathFind(map: map)
    }

    func createLargeMap(input: Input) -> Input {
        let h = input.count
        var newMap = [[Int]]()
        for y in 0..<5 {

            for x in 0..<5 {
                let factor = x + y
                let toInsert: [[Int]] = input.map { $0.map { ($0 + factor - 1) % 9 + 1 } }
                if x == 0 {
                    newMap.append(contentsOf: toInsert)
                } else {
                    for y2 in y*h ..< (y+1)*h {
                        newMap[y2].append(contentsOf: toInsert[y2 - y*h])
                    }
                }
            }
        }
        return newMap
    }
}
