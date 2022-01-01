import Foundation

class Day16 {
    typealias Input = [Int]
    typealias Position = Day9.Position

    enum Packet {
        case literal(data: [Int])
        case op(type: Int, subPackets: [Packet])

        var intValue: Int? {
            switch self {
            case let .literal(data: bits): return Day16.bitsToInt(bits)
            default: return nil
            }
        }

        func evaluate() -> Int {
            switch self {
            case .literal: return intValue!
            case .op(type: 0, subPackets: let packets): return packets.map { $0.evaluate() }.reduce(0, +)
            case .op(type: 1, subPackets: let packets): return packets.map { $0.evaluate() }.reduce(1, *)
            case .op(type: 2, subPackets: let packets): return packets.map { $0.evaluate() }.min()!
            case .op(type: 3, subPackets: let packets): return packets.map { $0.evaluate() }.max()!
            case .op(type: 5, subPackets: let packets): return (packets[0].evaluate() >  packets[1].evaluate()) ? 1 : 0
            case .op(type: 6, subPackets: let packets): return (packets[0].evaluate() <  packets[1].evaluate()) ? 1 : 0
            case .op(type: 7, subPackets: let packets): return (packets[0].evaluate() == packets[1].evaluate()) ? 1 : 0
            default: fatalError()
            }
        }
    }

    func parse(input: String) -> Input {
        input.hexaToBinary.map { Int("\($0)")! }
    }

    func partA(input: Input) -> Int {
        var input = input.dropFirst(0)
        versionSum = 0
        _ = readPacket(input: &input)!.evaluate()
        return versionSum
    }

    func partB(input: Input) -> Int {
        var input = input.dropFirst(0)
        return readPacket(input: &input)!.evaluate()
    }

    var versionSum = 0
    func readPacket(input: inout Array<Int>.SubSequence) -> Packet? {
        guard
            let v = readInt(3, &input),
            let t = readInt(3, &input) else { return nil }
        versionSum += v
        if t == 4 {
            return parseLiteralPacket(input: &input)
        }
        return parseOperatorPacket(type: t,input: &input)
    }

    func parseLiteralPacket(input: inout Array<Int>.SubSequence) -> Packet {
        var value: [Int] = []
        while true {
            let hasMore = read(&input) == 1
            value += read(4, &input)
            guard hasMore else { return .literal(data: value) }
        }
    }

    func parseOperatorPacket(type: Int, input: inout Array<Int>.SubSequence) -> Packet {
        let i = read(&input)
        let length = readInt(i == 0 ? 15 : 11, &input)!
        if i == 0 {
            var data = read(length, &input)

            var packets: [Packet] = []
            while true {
                guard let next = readPacket(input: &data) else { break }
                packets += [next]
            }
            return .op(type: type, subPackets: packets)
        } else {
            let packets = (0 ..< length).map { _ in readPacket(input: &input)! }
            return .op(type: type, subPackets: packets)
        }
    }

    func readInt(_ count: Int, _ input: inout Array<Int>.SubSequence) -> Int? {
        guard input.count >= count else { return nil }
        let bits = read(count, &input)
        return Self.bitsToInt(bits)
    }

    func read(_ count: Int, _ input: inout Array<Int>.SubSequence) -> Array<Int>.SubSequence {
        defer { input = input.dropFirst(count) }
        return input.prefix(count)
    }

    func read(_ input: inout Array<Int>.SubSequence) -> Int? {
        read(1, &input).first
    }

    static func bitsToInt<T: Sequence>(_ bits: T) -> Int where T.Element == Int {
        bits.reversed().enumerated().reduce(0) { $0 + $1.element * (1 << $1.offset) }
    }
}

extension String {
    typealias Byte = UInt8
    var hexaToBytes: [Byte] {
        var start = startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in // use flatMap for older Swift versions
            let end = index(after: start)
            defer { start = index(after: end) }
            return Byte(self[start ... end], radix: 16)
        }
    }

    var hexaToBinary: String {
        hexaToBytes.map {
            let binary = String($0, radix: 2)
            return repeatElement("0", count: 8 - binary.count) + binary
        }.joined()
    }
}
