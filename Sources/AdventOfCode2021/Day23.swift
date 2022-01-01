import Foundation
private let energy: [Character: Int] = ["A": 1, "B": 10, "C": 100, "D": 1000]
class Day23 {
    struct Input: Hashable {
        var a: [Character]
        var b: [Character]
        var c: [Character]
        var d: [Character]
        var hallway: [Character?] = Array(repeating: nil, count: 11)
        var e: Int

        var ab: Character? { hallway[3] }
        var bc: Character? { hallway[5] }
        var cd: Character? { hallway[7] }

        var isSolved: Bool {
            return a == ["A", "A"] && b == ["B", "B"] && c == ["C", "C"] && d == ["D", "D"]
        }

        func isAOpen() -> Bool {
            return a.allSatisfy { $0 == "A" } && a.count < 2
        }

        func isBOpen() -> Bool {
            return b.allSatisfy { $0 == "B" } && b.count < 2
        }

        func isCOpen() -> Bool {
            return c.allSatisfy { $0 == "C" } && c.count < 2
        }

        func isDOpen() -> Bool {
            return d.allSatisfy { $0 == "D" } && d.count < 2
        }

        func canMove(from: Int, to: Int) -> Bool {
            let direction = to > from ? 1 : -1
            let l = min(from + direction, to)
            let h = max(from + direction, to)
            return (l ... h).allSatisfy { hallway[$0] == nil }
        }

        func draw() {
            var result = "#############\n"
            result += "#"
            hallway.forEach { result += "\($0 ?? ".")" }
            result += "#\n"
            result += "###"
            result += "\(a.dropLast().first ?? ".")"
            result += "#"
            result += "\(b.dropLast().first ?? ".")"
            result += "#"
            result += "\(c.dropLast().first ?? ".")"
            result += "#"
            result += "\(d.dropLast().first ?? ".")"
            result += "###\n"
            result += "  #"
            result += "\(a.last ?? ".")"
            result += "#"
            result += "\(b.last ?? ".")"
            result += "#"
            result += "\(c.last ?? ".")"
            result += "#"
            result += "\(d.last ?? ".")"
            result += "#\n"
            result += "  #########"
            print(result)
        }

        func moveFromAToCoridor() -> [Input] {
            guard let v = a.first else { return [] }
            if a.last == "A", a.first == "A" { return [] }
            let new = Array(a.dropFirst())
            var result: [Input] = []
            if canMove(from: 2, to: 0) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 0), e: e + (2 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 1) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 1), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 3) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 3), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 5) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 5), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 7) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 7), e: e + (5 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 9) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 9), e: e + (7 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 2, to: 10) {
                result +=
                    [Input(a: new, b: b, c: c, d: d, hallway: hallway.inserting(v, at: 10), e: e + (8 + (2 - new.count)) * energy[v]!)]
            }
            return result
        }

        func moveFromBToCoridor() -> [Input] {
            guard let v = b.first else { return [] }
            if b.last == "B", b.first == "B" { return [] }
            let new = Array(b.dropFirst())
            var result: [Input] = []
            if canMove(from: 4, to: 0) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 0), e: e + (4 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 1) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 1), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 3) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 3), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 5) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 5), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 7) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 7), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 9) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 9), e: e + (5 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 4, to: 10) {
                result +=
                    [Input(a: a, b: new, c: c, d: d, hallway: hallway.inserting(v, at: 10), e: e + (6 + (2 - new.count)) * energy[v]!)]
            }
            return result
        }

        func moveFromCToCoridor() -> [Input] {
            guard let v = c.first else { return [] }
            if c.last == "C", c.first == "C" { return [] }
            let new = Array(c.dropFirst())
            var result: [Input] = []
            if canMove(from: 6, to: 0) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 0), e: e + (6 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 1) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 1), e: e + (5 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 3) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 3), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 5) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 5), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 7) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 7), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 9) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 9), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 6, to: 10) {
                result +=
                    [Input(a: a, b: b, c: new, d: d, hallway: hallway.inserting(v, at: 10), e: e + (4 + (2 - new.count)) * energy[v]!)]
            }
            return result
        }

        func moveFromDToCoridor() -> [Input] {
            guard let v = d.first else { return [] }
            if d.last == "D", d.first == "D" { return [] }
            let new = Array(d.dropFirst())
            var result: [Input] = []
            if canMove(from: 8, to: 0) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 0), e: e + (8 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 1) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 1), e: e + (7 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 3) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 3), e: e + (5 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 5) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 5), e: e + (3 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 7) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 7), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 9) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 9), e: e + (1 + (2 - new.count)) * energy[v]!)]
            }
            if canMove(from: 8, to: 10) {
                result +=
                    [Input(a: a, b: b, c: c, d: new, hallway: hallway.inserting(v, at: 10), e: e + (2 + (2 - new.count)) * energy[v]!)]
            }
            return result
        }
    }

    typealias Position = Day9.Position

    func parse(input: String) -> Input {
        let lines = input.split(separator: "\n").map { $0.map { $0 } }
        let a = [lines[2][3], lines[3][3]]
        let b = [lines[2][5], lines[3][5]]
        let c = [lines[2][7], lines[3][7]]
        let d = [lines[2][9], lines[3][9]]
        return Input(a: a, b: b, c: c, d: d, e: 0)
    }

    func partA(input: Input) -> Int {
        var open: [[Input]] = Array(repeating: [], count: 30000)
        open[0] = [input]
        var closed: Set<Input> = [input]

        // while let next = open.min(by: { $0.e < $1.e }) {
        for i in 0 ..< 30000 {
            while let next = open[i].removingFirst() {
                if next.isSolved { return next.e }
                print("energy: \(next.e)")
                let options = Set(move(input: next)).subtracting(closed)
                // open = open.union(options)
                options.forEach {
                    open[$0.e] += [$0]
                }
                closed = closed.union(options)
            }
        }
        fatalError()
    }

    func recursive(input: Input) -> Input? {
        if input.isSolved { return input }
        print("Energy: \(input.e)")
        input.draw()
        print("\n")
        let possible = move(input: input).sorted(by: { $0.e < $1.e })

        return possible.first(where: { recursive(input: $0) != nil })
    }

    func move(input: Input) -> [Input] {
        if let obvious = obviousMove(input: input) { return [obvious] }

        return
            input.moveFromAToCoridor() +
            input.moveFromBToCoridor() +
            input.moveFromCToCoridor() +
            input.moveFromDToCoridor()
    }

    func obviousMove(input: Input) -> Input? {
        var i = input
        if i.isAOpen() {
            if let index = i.hallway.enumerated().first(where: { $0.1 == "A" && i.canMove(from: $0.0, to: 2) })?.0 {
                let v = i.hallway[index]!
                i.e += (abs(2 - index) + 2 - i.a.count) * energy[v]!
                i.a.insert(v, at: 0)
                i.hallway[index] = nil
                print("Coridor to a")
                return i
            }
            if i.b.first == "A", i.canMove(from: 4, to: 2) {
                let v = i.b.removeFirst()
                i.e += (2 + 2 - i.a.count + 2 - i.b.count) * energy[v]!
                i.a.insert(v, at: 0)
                print("B to A")
                return i
            }
            if i.c.first == "A", i.canMove(from: 6, to: 2) {
                let v = i.c.removeFirst()
                i.e += (4 + 2 - i.a.count + 2 - i.c.count) * energy[v]!
                i.a.insert(v, at: 0)
                print("C to A")
                return i
            }
            if i.d.first == "A", i.canMove(from: 8, to: 2) {
                let v = i.d.removeFirst()
                i.e += (6 + 2 - i.a.count + 2 - i.d.count) * energy[v]!
                i.a.insert(v, at: 0)
                print("D to A")
                return i
            }
        }
        if input.isBOpen() {
            if let index = i.hallway.enumerated().first(where: { $0.1 == "B" && i.canMove(from: $0.0, to: 4) })?.0 {
                let v = i.hallway[index]!
                i.e += (abs(4 - index) + 2 - i.b.count) * energy[v]!
                i.b.insert(i.hallway[index]!, at: 0)
                i.hallway[index] = nil
                print("Coridor to b")
                return i
            }
            if i.a.first == "B", i.canMove(from: 2, to: 4) {
                let v = i.a.removeFirst()
                i.e += (2 + 2 - i.b.count + 2 - i.a.count) * energy[v]!
                i.b.insert(v, at: 0)
                print("A to B")
                return i
            }
            if i.c.first == "B", i.canMove(from: 6, to: 4) {
                let v = i.c.removeFirst()
                i.e += (2 + 2 - i.b.count + 2 - i.c.count) * energy[v]!
                i.b.insert(v, at: 0)
                print("C to B")
                return i
            }
            if i.d.first == "B", i.canMove(from: 8, to: 4) {
                let v = i.d.removeFirst()
                i.e += (4 + 2 - i.b.count + 2 - i.d.count) * energy[v]!
                i.b.insert(v, at: 0)
                print("D to B")
                return i
            }
        }
        if input.isCOpen() {
            if let index = i.hallway.enumerated().first(where: { $0.1 == "C" && i.canMove(from: $0.0, to: 6) })?.0 {
                let v = i.hallway[index]!
                i.e += (abs(6 - index) + 2 - i.c.count) * energy[v]!
                i.c.insert(i.hallway[index]!, at: 0)
                i.hallway[index] = nil
                print("Coridor to c")
                return i
            }
            if i.a.first == "C", i.canMove(from: 2, to: 6) {
                let v = i.a.removeFirst()
                i.e += (4 + 2 - i.c.count + 2 - i.a.count) * energy[v]!
                i.c.insert(v, at: 0)
                print("A to C")
                return i
            }
            if i.b.first == "C", i.canMove(from: 4, to: 6) {
                let v = i.b.removeFirst()
                i.e += (2 + 2 - i.c.count + 2 - i.b.count) * energy[v]!
                i.c.insert(v, at: 0)
                print("B to C")
                return i
            }
            if i.d.first == "C", i.canMove(from: 8, to: 6) {
                let v = i.d.removeFirst()
                i.e += (2 + 2 - i.c.count + 2 - i.d.count) * energy[v]!
                i.c.insert(v, at: 0)
                print("d to C")
                return i
            }
        }
        if input.isDOpen() {
            if let index = i.hallway.enumerated().first(where: { $0.1 == "D" && i.canMove(from: $0.0, to: 8) })?.0 {
                let v = i.hallway[index]!
                i.e += (abs(8 - index) + 2 - i.d.count) * energy[v]!
                i.d.insert(i.hallway[index]!, at: 0)
                i.hallway[index] = nil
                print("Coridor to d")
                return i
            }
            if i.a.first == "D", i.canMove(from: 2, to: 8) {
                let v = i.a.removeFirst()
                i.e += (6 + 2 - i.d.count + 2 - i.a.count) * energy[v]!
                i.d.insert(v, at: 0)
                print("A to D")
                return i
            }
            if i.b.first == "D", i.canMove(from: 4, to: 8) {
                let v = i.b.removeFirst()
                i.e += (4 + 2 - i.d.count + 2 - i.b.count) * energy[v]!
                i.d.insert(v, at: 0)
                print("A to D")
                return i
            }
            if i.c.first == "D", i.canMove(from: 6, to: 8) {
                let v = i.c.removeFirst()
                i.e += (2 + 2 - i.d.count + 2 - i.c.count) * energy[v]!
                i.d.insert(v, at: 0)
                print("C to D")
                return i
            }
        }
        return nil
    }

}

extension Array {
    func inserting(_ e: Element, at index: Index) -> Self {
        var copy = self
        copy[index] = e
        return copy
    }

    func moving<T>(_ e: T, at index: Index, from: Index) -> Self where Element == T?{
        var copy = self
        copy[index] = e
        copy[from] = nil
        return copy
    }

    mutating func removingFirst() -> Element? {
        defer { self = Array(self.dropFirst()) }
        return first
    }
}
