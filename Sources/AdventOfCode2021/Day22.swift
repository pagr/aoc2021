import Foundation

class Day22 {
    struct Instruction: Equatable {
        let state: Bool
        let low: Position
        let high: Position

        var volume: Int { (high.x - low.x) * (high.y - low.y) * (high.z - low.z) }
        func getOverlap(_ other: Instruction) -> Instruction? {
            guard overlaps(other) else { return nil }
            let lx = max(low.x, other.low.x)
            let ly = max(low.y, other.low.y)
            let lz = max(low.z, other.low.z)
            let hx = min(high.x, other.high.x)
            let hy = min(high.y, other.high.y)
            let hz = min(high.z, other.high.z)

            return Instruction(
                state: other.state,
                low: Position(x: min(lx, hx), y: min(ly, hy), z: min(lz, hz)),
                high: Position(x: max(lx, hx), y: max(ly, hy), z: max(lz, hz))
            )
        }

        func contains(_ other: Instruction) -> Bool {
            if other.low.x > low.x, other.high.x < high.x,
               other.low.y > low.y, other.high.y < high.y,
               other.low.z > low.z, other.high.z < high.z {
                return true
            }
            return false
        }

        func overlaps(_ other: Instruction) -> Bool {

            if (low.x ..< high.x).overlaps(other.low.x ..< other.high.x),
               (low.y ..< high.y).overlaps(other.low.y ..< other.high.y),
               (low.z ..< high.z).overlaps(other.low.z ..< other.high.z) {
                return true
            }
            return false
        }

        var includedPoints: Set<Position> {
            var result: Set<Position> = []
            guard (-50 ... 50).contains(low.x) || (-50 ... 50).contains(high.x),
                  (-50 ... 50).contains(low.y) || (-50 ... 50).contains(high.y),
                  (-50 ... 50).contains(low.z) || (-50 ... 50).contains(high.z) else { return [] }
            for x in max(low.x, -50) ... min(high.x, 50) {
                for y in max(low.y, -50) ... min(high.y, 50) {
                    for z in max(low.z, -50) ... min(high.z, 50) {
                        result.insert(Position(x: x, y: y, z: z))
                    }
                }
            }
            return result
        }

        var includedPoints2: Set<Position> {
            var result: Set<Position> = []
            guard (-50 ..< 50).contains(low.x) || (-50 ... 50).contains(high.x),
                  (-50 ..< 50).contains(low.y) || (-50 ... 50).contains(high.y),
                  (-50 ..< 50).contains(low.z) || (-50 ... 50).contains(high.z) else { return [] }
            for x in max(low.x, -50) ..< min(high.x, 50) {
                for y in max(low.y, -50) ..< min(high.y, 50) {
                    for z in max(low.z, -50) ..< min(high.z, 50) {
                        result.insert(Position(x: x, y: y, z: z))
                    }
                }
            }
            return result
        }
    }

    typealias Input = [Instruction]
    typealias Position = Day19.Position

    func parse(input: String) -> Input {
        input.components(separatedBy: "\n").map {
            // on x=-31..15,y=-40..12,z=-21..27
            let parts = $0.split(separator: ",")
            let state = $0.prefix(2) == "on"
            let lx = Int(parts[0].split(separator: "=")[1].split(separator: ".")[0])!
            let hx = Int(parts[0].split(separator: "=")[1].split(separator: ".")[1])!

            let ly = Int(parts[1].split(separator: "=")[1].split(separator: ".")[0])!
            let hy = Int(parts[1].split(separator: "=")[1].split(separator: ".")[1])!

            let lz = Int(parts[2].split(separator: "=")[1].split(separator: ".")[0])!
            let hz = Int(parts[2].split(separator: "=")[1].split(separator: ".")[1])!

            return Instruction(
                state: state,
                low: Position(x: min(lx, hx), y: min(ly, hy), z: min(lz, hz)),
                high: Position(x: max(lx, hx), y: max(ly, hy), z: max(lz, hz))
            )
        }
    }

    func partA(input instructions: Input) -> Int {
        var reactor = Set<Position>()

        for instruction in instructions {
            if instruction.state {
                reactor = reactor.union(instruction.includedPoints)
            } else {
                reactor = reactor.subtracting(instruction.includedPoints)
            }
        }
        return reactor.count
    }

    func partB(input instructions: Input) -> Int {
        let world = Instruction(
            state: false,
            low: Position(x: instructions.map(\.low.x).min()!,
                          y: instructions.map(\.low.y).min()!,
                          z: instructions.map(\.low.z).min()!),
            high: Position(x: instructions.map(\.high.x).max()!,
                           y: instructions.map(\.high.y).max()!,
                           z: instructions.map(\.high.z).max()!) + Position(x: 1, y: 1, z: 1)
        )
        return count(in: world, instructions: instructions)
    }

    func count(in ins: Instruction, instructions: Input) -> Int{
        var splits = [ins]
        var instructions = instructions
            .map { Instruction(state: $0.state,
                               low: $0.low,
                               high: $0.high + Position(x: 1, y: 1, z: 1)) }
            .dropFirst(0)

        while let other = instructions.popFirst() {
            var newSplits: [Instruction] = []
            for split in splits {
                if split.overlaps(other) || split.contains(other) {
                    newSplits += divide(ins: split, other: other)
                } else {
                    newSplits += [split]
                }
            }
            splits = newSplits
        }

        return splits
            .filter { $0.state }
            .map(\.volume)
            .reduce(0, +)
    }

    func divide(ins: Instruction, other: Instruction) -> [Instruction] {
        let overlap = ins.getOverlap(other)!

        // over under
        let zl = Instruction(state: ins.state,
                             low: Position(x: overlap.low.x, y: overlap.low.y, z: ins.low.z),
                             high: Position(x: overlap.high.x, y: overlap.high.y, z: overlap.low.z))

        let zh = Instruction(state: ins.state,
                             low: Position(x: overlap.low.x, y: overlap.low.y, z: overlap.high.z),
                             high: Position(x: overlap.high.x, y: overlap.high.y, z: ins.high.z))
        // corners
        let lxly = Instruction(state: ins.state,
                               low: Position(x: ins.low.x, y: ins.low.y, z: ins.low.z),
                               high: Position(x: overlap.low.x, y: overlap.low.y, z: ins.high.z))

        let hxly = Instruction(state: ins.state,
                               low: Position(x: overlap.high.x, y: ins.low.y, z: ins.low.z),
                               high: Position(x: ins.high.x, y: overlap.low.y, z: ins.high.z))

        let lxhy = Instruction(state: ins.state,
                               low: Position(x: ins.low.x, y: overlap.high.y, z: ins.low.z),
                               high: Position(x: overlap.low.x, y: ins.high.y, z: ins.high.z))

        let hxhy = Instruction(state: ins.state,
                               low: Position(x: overlap.high.x, y: overlap.high.y, z: ins.low.z),
                               high: Position(x: ins.high.x, y: ins.high.y, z: ins.high.z))
        // sides
        let lx = Instruction(state: ins.state,
                             low: Position(x: ins.low.x, y: overlap.low.y, z: ins.low.z),
                             high: Position(x: overlap.low.x, y: overlap.high.y, z: ins.high.z))

        let hx = Instruction(state: ins.state,
                             low: Position(x: overlap.high.x, y: overlap.low.y, z: ins.low.z),
                             high: Position(x: ins.high.x, y: overlap.high.y, z: ins.high.z))

        let ly = Instruction(state: ins.state,
                             low: Position(x: overlap.low.x, y: ins.low.y, z: ins.low.z),
                             high: Position(x: overlap.high.x, y: overlap.low.y, z: ins.high.z))

        let hy = Instruction(state: ins.state,
                             low: Position(x: overlap.low.x, y: overlap.high.y, z: ins.low.z),
                             high: Position(x: overlap.high.x, y: ins.high.y, z: ins.high.z))

        let parts = [overlap, lx, hx, ly, hy, zl, zh,
                     lxly, hxly, lxhy, hxhy]

        for a in parts {
            for b in parts where a != b {
                assert(!a.overlaps(b))
            }
        }
        let totalVolume = parts.map(\.volume).reduce(0, +)
        assert(ins.volume == totalVolume)

        return parts.filter { $0.volume > 0 }
    }

    func drawMap(position: Set<Position>) {
        var result = ""
        let lx = 8
        let hx = 14
        let ly = 8
        let hy = 14
        for y in ly ..< hy {
            for x in lx ..< hx {
                var value: Int = 0
                for z in 0 ..< 20 {
                    if position.contains(Position(x: x, y: y, z: z)) {
                        value += 1
                    }
                }
                result += "\(min(value, 9))"
            }
            result += "\n"
        }
        print(result)
    }
}
