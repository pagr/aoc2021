import Foundation

class Day25 {
    struct Input: Equatable {
        var w: Int
        var h: Int
        var r: Set<Position>
        var d: Set<Position>

        func draw() {
            var result = ""
            for y in 0..<h {
                for x in 0..<w {
                    let p = Position(x: x, y: y)
                    if r.contains(p) {
                         result += ">"
                    } else if d.contains(p) {
                        result += "v"
                    } else {
                         result += "."
                    }
                }
                result += "\n"
            }
            print("\(result)")
        }
    }
    typealias Position = Day9.Position

    func parse(input: String) -> Input {
        var r: Set<Position> = []
        var d: Set<Position> = []
        let w = input.components(separatedBy: "\n").first!.count
        let h = input.components(separatedBy: "\n").count
        input.components(separatedBy: "\n").enumerated().forEach { y, line in
            line.enumerated().forEach { x, c in
                if c == ">" {
                    r.insert(Position(x: x, y: y))
                } else if c == "v" {
                    d.insert(Position(x: x, y: y))
                }
            }
        }
        return Input(w: w, h: h, r: r, d: d)
    }

    func partA(input : Input) -> Int {
        run(input, steps: Int.max).steps
    }

    func run(_ input: Input, steps: Int) -> (next: Input, steps: Int) {
        let w = input.w
        let h = input.h
        var input = input
        var count = 0
        while true {
            var moves = 0
            let r = input.r.map { p -> Position in
                let n = (p + Position.r).wrapping(w: w, h: h)
                if input.r.contains(n) || input.d.contains(n) {
                    return p
                }
                moves += 1
                return n
            }

            let d = input.d.map { p -> Position in
                let n = (p + Position.d).wrapping(w: w, h: h)
                if input.d.contains(n) ||
                    r.contains(n) {
                    return p
                }
                moves += 1
                return n
            }
            count += 1
            input = Input(w: w, h: h, r: Set(r), d: Set(d))
            if moves == 0 || count == steps {
                return (input, count)
            }
            //print("\nMoves: \(moves)")
            //input.draw()
            //Thread.sleep(forTimeInterval: 1)

        }
    }

    func partB(input: Input) -> Int {
        0
    }
}
