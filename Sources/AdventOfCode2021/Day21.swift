import Foundation

class Day21 {
    typealias Position = Day9.Position

    func partA(input: [Int]) -> Int {
        var a = input[0]
        var b = input[1]
        var sa = 0
        var sb = 0

        while true {
            let distance1 = rollDice3()
            a = (a + distance1 - 1) % 10 + 1
            sa += a
            print("Player 1 rolls \(distance1) and moves to space \(a) for a total score of \(sa).")
            if sa >= 1000 {
                return sb * rolls
            }

            let distance2 = rollDice3()
            b = (b + distance2 - 1) % 10 + 1
            sb += b
            print("Player 2 rolls \(distance2) and moves to space \(b) for a total score of \(sb).")
            if sb >= 1000 {
                return sa * rolls
            }
        }
    }

    var diceValue: Int = 1
    var rolls: Int = 0
    func rollDice3() -> Int {
        return rollDice() + rollDice() + rollDice()
    }

    func rollDice() -> Int {
        defer {
            rolls += 1
            diceValue += 1
            if diceValue > 100 { diceValue = 1 }
        }
        return diceValue
    }

    func partB(input: [Int]) -> Int {
        let a = input[0]
        let b = input[1]
        let (sa, sb) = step(a: a, b: b, sa: 0, sb: 0)

        if sa > sb {
            return sa
        }
        return sb
    }

    let table = [
        (d: 3, c: 1),
        (d: 4, c: 3),
        (d: 5, c: 6),
        (d: 6, c: 7),
        (d: 7, c: 6),
        (d: 8, c: 3),
        (d: 9, c: 1),
    ]
    var cache: [String: (Int, Int)] = [:]
    func step(a: Int, b: Int, sa: Int, sb: Int, level: Int = 0) -> (Int, Int) {
        let key = "\(a).\(b).\(sa).\(sb)"
        if let cached = cache[key] { return cached }
        var wina = 0
        var winb = 0
        for (d, c) in table {
            let na = (a + d - 1) % 10 + 1
            let nsa = sa + na
            if nsa >= 21 {
                wina += c; continue
            }
            for (d2, c2) in table {
                let nb = (b + d2 - 1) % 10 + 1
                let nsb = sb + nb
                if nsb >= 21 {
                    winb += c * c2; continue
                }

                let tmp = step(a: na, b: nb, sa: nsa, sb: nsb, level: level + 1)
                wina += tmp.0 * c * c2
                winb += tmp.1 * c * c2
            }
        }
        cache[key] = (wina, winb)
        return (wina, winb)
    }
}
