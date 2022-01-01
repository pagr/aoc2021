import Foundation

class Day20 {
    struct Input {
        let imageEnhancement: [Bool]
        let image: Set<Position>
        let bg: Bool

        func valueAt(p: Position, bg: Bool) -> Int{
            var v: Int = 0
            v += (image.contains(Position(x: p.x - 1, y: p.y - 1)) != bg ? 256 : 0)
            v += (image.contains(Position(x: p.x + 0, y: p.y - 1)) != bg ? 128 : 0)
            v += (image.contains(Position(x: p.x + 1, y: p.y - 1)) != bg ? 64 : 0)

            v += (image.contains(Position(x: p.x - 1, y: p.y - 0)) != bg ? 32 : 0)
            v += (image.contains(Position(x: p.x + 0, y: p.y - 0)) != bg ? 16 : 0)
            v += (image.contains(Position(x: p.x + 1, y: p.y - 0)) != bg ? 8 : 0)

            v += (image.contains(Position(x: p.x - 1, y: p.y + 1)) != bg ? 4 : 0)
            v += (image.contains(Position(x: p.x + 0, y: p.y + 1)) != bg ? 2 : 0)
            v += (image.contains(Position(x: p.x + 1, y: p.y + 1)) != bg ? 1 : 0)

            return v
        }
    }
    typealias Position = Day9.Position

    struct PositionWithScore: Hashable {
        let x, y, s: Int
    }

    func parse(input: String) -> Input {
        let parts = input.components(separatedBy: "\n\n")
        let ie = parts[0].map({ $0 == "#" })
        let grid = parts[1].split(separator: "\n").map {
            $0.map { $0 == "#" }
        }
        let image: [Position] = grid.enumerated().flatMap { y, line in
            line.enumerated().compactMap { x, pixel in
                if pixel { return Position(x: x, y: y) }
                return nil
            }
        }
        return Input(imageEnhancement: ie, image: Set(image), bg: false)
    }

    func partA(input map: Input) -> Int {
        var input = map
        input = enhance(input: input)
        input = enhance(input: input)
        return input.image.count
    }

    func partB(input: Input) -> Int {
        var input = input
        for _ in 0..<50 {
            input = enhance(input: input)
        }
        return input.image.count
    }

    func enhance(input: Input) -> Input {
        let minX = input.image.map(\.x).min()! - 1
        let maxX = input.image.map(\.x).max()! + 1
        let minY = input.image.map(\.y).min()! - 1
        let maxY = input.image.map(\.y).max()! + 1
        let bg = input.imageEnhancement[0] != input.bg
        var output = Set<Position>()
        for y in minY...maxY {
            for x in minX...maxX {
                let index = input.valueAt(p: .init(x: x, y: y), bg: input.bg)
                if input.imageEnhancement[index] != bg {
                    output.insert(.init(x: x, y: y))
                }
            }
        }
        return Input(imageEnhancement: input.imageEnhancement, image: output, bg: bg)
    }

    func drawImage(image: Set<Position>) {
        let minX = image.map(\.x).min()!
        let maxX = image.map(\.x).max()!
        let minY = image.map(\.y).min()!
        let maxY = image.map(\.y).max()!
        var result: String = ""
        for y in minY...maxY {
            result += "\n"
            for x in minX...maxX {
                if image.contains(.init(x: x, y: y)) {
                    result += "#"
                } else {
                    result += "."
                }
            }
        }
        print(result + "\n")
    }
}
