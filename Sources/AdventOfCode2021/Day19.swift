import Foundation
import XCTest

class Day19 {
    typealias Input = [Scanner]

    class Scanner: Hashable {
        static func == (lhs: Day19.Scanner, rhs: Day19.Scanner) -> Bool {
            lhs.beacons == rhs.beacons
        }

        var name: String
        var p: Position
        var beacons: [Position]
        let rotatedBeacons: [[Position]]

        init(beacons: [Position]) {
            self.beacons = beacons
            p = .init(x: 0, y: 0, z: 0)
            rotatedBeacons = beacons.map { $0.allRotations() }.transposed()
            name = UUID().uuidString
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(beacons)
        }

    }

    func parse(input: String) -> Input {
        input.components(separatedBy: "\n\n").map {
            let beacons = $0.split(separator: "\n").dropFirst().map { line -> Position in
                let parts = line.split(separator: ",")
                return Position(x: Int("\(parts[0])")!, y: Int("\(parts[1])")!, z: Int("\(parts[2])")!)
            }
            return Scanner(beacons: beacons)
        }
    }

    func partA(input scanners: Input) -> Int {
        let knownScanners = solve(input: scanners)
        let positions = knownScanners
            .map { Set($0.beacons) }
            .reduce(Set<Position>(), { $0.union($1) })
        return positions.count
    }

    func partB(input scanners: Input) -> Int {
        let knownScanners = solve(input: scanners)

        return knownScanners.flatMap { a in
            knownScanners.map { b in
                a.p.manhattan(to: b.p)
            }
        }.max()!
    }
    var cache: [Input: [Scanner]] = [:]
    func solve(input scanners: Input) -> [Scanner] {
        if let cached = cache[scanners] { return cached }
        var unknownScanners = Array(scanners.dropFirst())
        var knownScanners = [scanners.first!]
        var computed: Set<String> = []
        while !unknownScanners.isEmpty {
            for k in knownScanners {
                for u_index in 0 ..< unknownScanners.count {
                    let u = unknownScanners[u_index]
                    let key = k.name + u.name
                    guard computed.insert(key).inserted else { continue }
                    if isOverlapping(scanner: k, other: u) {
                        print("Found overlap \(knownScanners.count) / \(scanners.count)")
                        knownScanners.append(u)
                        unknownScanners.remove(at: u_index)
                        break
                    }
                }
            }
        }
        cache[scanners] = knownScanners
        return knownScanners
    }

    func isOverlapping(scanner: Scanner, other: Scanner) -> Bool {
        let beacons = Set(scanner.beacons)
        for r in 0 ..< 24 {
            for b in 0 ..< (scanner.beacons.count - 11) {
                for o in other.rotatedBeacons[r].dropFirst(11) {
                    let offset = scanner.beacons[b] - o

                    if beacons.intersection(other.rotatedBeacons[r].map { $0 + offset }).count >= 12 {
                        other.p = offset
                        other.beacons = other.rotatedBeacons[r].map { $0 + offset }
                        return true
                    }
                }
            }
        }
        return false
    }

    struct Position: Hashable, CustomDebugStringConvertible {
        let x, y, z: Int

        static let zero = Position(x: 0, y: 0, z: 0)
        static let one = Position(x: 1, y: 1, z: 1)

        var debugDescription: String {
            return "\(x),\(y),\(z)"
        }

        static func + (lhs: Position, rhs: Position) -> Position {
            return Position(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
        }

        static func - (lhs: Position, rhs: Position) -> Position {
            return Position(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
        }

        func manhattan(to other: Position) -> Int {
            return abs(x - other.x) + abs(y - other.y) + abs(z - other.z)
        }

        func allRotations() -> [Position] {
            var v = self
            var sum: [Position] = []
            for _ in 0 ..< 2 {
                for _ in 0 ..< 3 {
                    v = v.roll()
                    sum += [v]

                    for _ in 0 ..< 3 {
                        v = v.turn()
                        sum += [v]
                    }
                }
                v = v.roll().turn().roll()
            }
            return sum
        }

        func roll() -> Position { Position(x: x, y: z, z: -y) }
        func turn() -> Position { Position(x: -y, y: x, z: z) }
    }
}
