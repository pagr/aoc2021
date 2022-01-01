import Foundation

class Day17 {
    struct Target {
        let minX: Int, maxX: Int
        let minY: Int, maxY: Int
    }

    typealias Input = Target
    typealias Position = Day9.Position

    struct PositionWithScore: Hashable {
        let x, y, s: Int
    }

    func parse(input: String) -> Input {
        let parts = input.components(separatedBy: CharacterSet(charactersIn: ", "))
        let x = parts[2].components(separatedBy: "=")[1].components(separatedBy: "..").map { Int("\($0)")! }
        let y = parts[4].components(separatedBy: "=")[1].components(separatedBy: "..").map { Int("\($0)")! }
        return Target(minX: x[0], maxX: x[1], minY: y[0], maxY: y[1])
    }

    func partA(input t: Input) -> Int {
        let dy = (0 ..< 1000).filter { simulate(dx: 0, dy: $0, t: t) }.max()!
        return simulate2(dx: 0, dy: dy, t: t)
    }

    func partB(input t: Input) -> Int {
        let xs = (-1000 ..< 1000).flatMap { simulate3(dx: $0, t: t) }
        let ys = (-1000 ..< 1000).flatMap { simulate4(dy: $0, t: t) }
        return ys
            .map { y in
                xs.filter { $0.s <= y.s }.map { x -> (s: Int, dx: Int) in
                    return x
                }.filter {
                    verify(dx: $0.dx, dy: y.dy, t: t)
                }
                .count
            }
            .reduce(0, +)
    }

    func simulate(dx _: Int, dy: Int, t: Target) -> Bool {
        var dy = dy
        var y = 0
        for i in 0 ..< 1000 {
            y += dy
            dy -= 1
            if (t.minY ... t.maxY).contains(y) { return true }
            if y < t.minY, dy < 0 { return false }
        }
        return false
    }

    func simulate2(dx _: Int, dy: Int, t: Target) -> Int {
        var dy = dy
        var y = 0
        var maxY = 0
        for i in 0 ..< 1000 {
            y += dy
            dy -= 1
            maxY = max(y, maxY)
            if (t.minY ... t.maxY).contains(y) { return maxY }
            if y < t.minY, dy < 0 { return 0 }
        }
        fatalError()
    }

    func simulate3(dx: Int, t: Target) -> [(s: Int, dx: Int)] {
        var og = dx
        var dx = dx
        var x = 0
        for i in 0 ..< 1000 {
            x += dx
            if dx != 0 { dx += dx > 0 ? -1 : 1 }
            if (t.minX ... t.maxX).contains(x) { return [(i + 1, og)] }
            if dx == 0 { return [] }
        }
        return []
    }

    func simulate4(dy: Int, t: Target) -> [(s: Int, dy: Int)] {
        var og = dy
        var dy = dy
        var y = 0
        var results: [Int] = []
        for i in 0 ..< 1000 {
            y += dy
            dy -= 1
            if (t.minY ... t.maxY).contains(y) { results += [i + 1] }
            if y < t.minY, dy < 0 { return [results.max()].compactMap { $0 }.map { ($0, og) } }
        }
        return [results.max()].compactMap { $0 }.map { ($0, og) }
    }

    func verify(dx: Int, dy: Int, t: Target) -> Bool {
        var dy = dy
        var y = 0
        var dx = dx
        var x = 0
        for i in 0 ..< 1000 {
            y += dy
            dy -= 1
            x += dx
            if dx != 0 { dx += dx > 0 ? -1 : 1 }
            if (t.minY ... t.maxY).contains(y) {
                if (t.minX ... t.maxX).contains(x) {
                    return true
                }
            }
            if y < t.minY, dy < 0 { return false }
        }
        fatalError()
    }
}
