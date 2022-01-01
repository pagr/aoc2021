import Foundation

private var number: Int = 0

class Day18 {
    typealias Position = Day9.Position

    indirect enum Input: Equatable, CustomDebugStringConvertible {
        case number(n: Int)
        case pair(l: Input, r: Input)

        var debugDescription: String {
            switch self {
            case .number(let n):
                return "\(n)"
            case .pair(let l, let r):
                return "[\(l),\(r)]"
            }
        }

        var magnetude: Int {
            switch self {
            case .number(let n):
                return n
            case .pair(let l, let r):
                return 3 * l.magnetude + 2 * r.magnetude
            }
        }
        var maxLevel: Int {
            return OrderedInput(input: self, previous: nil, level: 0).children.map(\.level).max()!
        }
    }

    class OrderedInput {

        init(n: Int, l: Day18.OrderedInput?, r: Day18.OrderedInput?, next: Day18.OrderedInput?, previous: Day18.OrderedInput?, level: Int, index: Int?) {
            self.n = n
            self.l = l
            self.r = r
            self.next = next
            self.previous = previous
            self.level = level
            self.index = index
        }

        init(input: Input, previous: OrderedInput?, level: Int) {
            switch input {
            case .number(let n):
                //assert(level <= 5)
                self.n = n
                self.previous = previous
                self.level = level
                self.index = number
                number += 1
                previous?.next = self
            case .pair(let l, let r):
                //assert(level <= 4)
                self.level = level
                self.l = OrderedInput(input: l, previous: previous, level: level + 1)
                self.r = OrderedInput(input: r, previous: self.l, level: level + 1)
            }
        }

        func unordered() -> Input {
            if let n = n {
                return .number(n: n)
            }
            if let l = l, let r = r {
                return .pair(l: l.unordered(), r: r.unordered())
            }
            fatalError()
        }

        var n: Int?
        var l: OrderedInput?
        var r: OrderedInput?
        var next: OrderedInput?
        var previous: OrderedInput?
        var level: Int
        var index: Int?

        var children: [OrderedInput] {
            if let l = l, let r = r {
                return [self] + l.children + r.children
            }
            return [self]
        }
    }

    struct PositionWithScore: Hashable {
        let x, y, s: Int
    }
    func parse(input: String) -> [Input] {
        return input.split(separator: "\n").map { line -> Input in
            var line = line
            return parseRecursive(input: &line)
        }
    }
    func parseRecursive(input: inout String.SubSequence) -> Input {
        if input.hasPrefix("[") {
            input = input.dropFirst()
            let l = parseRecursive(input: &input)
            input = input.dropFirst()
            let r = parseRecursive(input: &input)
            input = input.dropFirst()
            return .pair(l: l, r: r)
        } else {
            defer { input = input.dropFirst() }
            return .number(n: Int("\(input.prefix(1))")!)
        }
    }

    func reduce(input: Input) -> Input {
        number = 0
        let ordered = OrderedInput(input: input, previous: nil, level: 0)
        let nodes = ordered.children
        let explode = nodes
            .first(where: { $0.level == 4 && $0.n == nil } )
        let split = nodes.first(where: { $0.n ?? 0 > 9 })

        if let explode = explode {
            self.explode(explode, nodes)
        } else if let split = split, let n = split.n {
            split.l = OrderedInput(n: n / 2, l: nil, r: nil, next: nil, previous: nil, level: split.level, index: nil)
            split.r = OrderedInput(n: (n + 1) / 2, l: nil, r: nil, next: nil, previous: nil, level: split.level, index: nil)
            split.n = nil
        } else {
            return input
        }

        return ordered.unordered()
    }

    func explode(_ explode: OrderedInput, _ nodes: [OrderedInput]) {
        if let prev = nodes.first(where: { $0.index == explode.l!.index! - 1 }){
            prev.n = prev.n! + explode.l!.n!
        }
        if let next = nodes.first(where: { $0.index == explode.r!.index! + 1 }) {
            next.n = next.n! + explode.r!.n!
        }
        explode.l = nil
        explode.r = nil
        explode.n = 0
    }

    func reduce2(input: Input) -> Input {
        var previous = input
        var next = input
        repeat {
            previous = next
            next = reduce(input: previous)

        } while next != previous
        return next
    }
    func add(a: Input, b: Input) -> Input {
        let a = reduce2(input: a)
        let b = reduce2(input: b)
        let added = Input.pair(l: a, r: b)
        return reduce2(input: added)
    }

    func add(input: [Input]) -> Input {
        return input
            .dropFirst()
            .reduce(input.first!) { a,b -> Input in
                return self.add(a: a, b: b)
            }
    }

    func partA(input: [Input]) -> Int {
        
        return add(input: input)
            .magnetude

    }

    func partB(input: [Input]) -> Int {
        var m: Int = 0
        for a in input {
            for b in input where a != b{
                m = max(m, add(a: a, b: b).magnetude)
            }
        }
        return m
    }
}
