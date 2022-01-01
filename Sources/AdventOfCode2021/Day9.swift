import Foundation

class Day9 {
    struct Position: Hashable, CustomDebugStringConvertible {
        let x, y: Int

        var debugDescription: String {
            return "[\(x),\(y)]"
        }

        static let r: Position = .init(x: 1, y: 0)
        static let d: Position = .init(x: 0, y: 1)

        static func + (lhs: Position, rhs: Position) -> Position {
            return Position(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
        }

        func wrapping(w: Int, h: Int) -> Position {
            let nx, ny: Int
            if x >= w { nx = x - w } else { nx = x }
            if y >= h { ny = y - h } else { ny = y }
            return .init(x: nx, y: ny)
        }
    }

    func parseInput(input: String) -> [[Int]] {
        return input.split(separator: "\n").map {
            $0.map { Int("\($0)")! }
        }
    }

    func findLow(map: [[Int]]) -> Int {
        let w = map.count
        let h = map[0].count
        var sum = 0

        for x in 0 ..< w {
            for y in 0 ..< h {
                if map[x][y] < map[safe: x + 1][safe: y],
                   map[x][y] < map[safe: x - 1][safe: y],
                   map[x][y] < map[safe: x][safe: y + 1],
                   map[x][y] < map[safe: x][safe: y - 1] {
                    sum += map[x][y] + 1
                }
            }
        }
        return sum
    }

    func findBasins(map: [[Int]]) -> Int {
        let w = map.count
        let h = map[0].count
        var basins: [Int] = []

        for x in 0 ..< w {
            for y in 0 ..< h {
                if map[x][y] < map[safe: x + 1][safe: y],
                   map[x][y] < map[safe: x - 1][safe: y],
                   map[x][y] < map[safe: x][safe: y + 1],
                   map[x][y] < map[safe: x][safe: y - 1] {
                    basins += [fillBasin(map: map, p: Position(x: x, y: y))]
                }
            }
        }
        return basins.sorted(by: { $0 > $1 }).prefix(3).reduce(1, *)
    }

    var fill: Set<Position> = []
    func fillBasin(map: [[Int]], p: Position) -> Int {
        guard !fill.contains(p) else { return 0 }

        func fillNext(p: Position) -> Int {
            var sum = 1
            fill.insert(p)
            if map[safe: p.x + 1][safe: p.y] >= map[p.x][p.y],
               map[safe: p.x + 1][safe: p.y] < 9,
               !fill.contains(Position(x: p.x + 1, y: p.y)) {
                sum += fillNext(p: Position(x: p.x + 1, y: p.y))
            }

            if map[safe: p.x - 1][safe: p.y] >= map[p.x][p.y],
               map[safe: p.x - 1][safe: p.y] < 9,
               !fill.contains(Position(x: p.x - 1, y: p.y)) {
                sum += fillNext(p: Position(x: p.x - 1, y: p.y))
            }

            if map[safe: p.x][safe: p.y + 1] >= map[p.x][p.y],
               map[safe: p.x][safe: p.y + 1] < 9,
               !fill.contains(Position(x: p.x, y: p.y + 1)) {
                sum += fillNext(p: Position(x: p.x, y: p.y + 1))
            }

            if map[safe: p.x][safe: p.y - 1] >= map[p.x][p.y],
               map[safe: p.x][safe: p.y - 1] < 9,
               !fill.contains(Position(x: p.x, y: p.y - 1)) {
                sum += fillNext(p: Position(x: p.x, y: p.y - 1))
            }

            return sum
        }

        fill.insert(p)
        let size = fillNext(p: p)
        return size
    }
}

extension Collection where Element == Int {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element {
        return indices.contains(index) ? self[index] : 9
    }
}

extension Collection where Element == [Int] {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element {
        return indices.contains(index) ? self[index] : []
    }
}
