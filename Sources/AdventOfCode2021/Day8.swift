import Foundation

struct Day8 {
    struct DigitTest {
        var patterns: [Set<Character>]
        var outputs: [Set<Character>]
        
        init(intput: String) {
            let parts = intput.split(separator: "|")
            
            patterns = parts[0].split(separator: " ").map { Set($0.map { c -> Character in c }) }
            outputs = parts[1].split(separator: " ").map { Set($0.map { c -> Character in c }) }
        }
    }
    
    func parse(input: String) -> [DigitTest] {
        input
            .split(separator: "\n")
            .map { 
                return DigitTest(intput: String($0))
            }
    }
    
    func findKnownDigits(d: [DigitTest]) -> Int {
        d.reduce(0) { $0 + findKnownDigits(d: $1) }
    }
    
    let digits: [Set<Character>] = [
        /* 0 */ ["a", "b", "c", "e", "f", "g"],
        /* 1 */ ["c", "f"],
        /* 2 */ ["a", "c", "d", "e", "g"],
        /* 3 */ ["a", "c", "d", "f", "g"],
        /* 4 */ ["b", "c", "d", "f"],
        /* 5 */ ["a", "b", "d", "f", "g"],
        /* 6 */ ["a", "b", "d", "e", "f", "g"],
        /* 7 */ ["a", "c", "f"],
        /* 8 */ ["a", "b", "c", "d", "e", "f", "g"],
        /* 9 */ ["a", "b", "c", "d", "f", "g"],
    ]
    
    func findKnownDigits(d: DigitTest) -> Int {
        var count = 0
        for out in d.outputs {
            if [2, 4, 3, 7].contains(out.count) {
                count += 1
            }
        }
        return count
    }
    
    func findAllKnownDigits(d: [DigitTest]) -> Int {
        return d.reduce(0, { $0 + findAllKnownDigits(d: $1)! } )
    }
    
    func findAllKnownDigits(d: DigitTest, table preTable: [Int: Set<Character>] = [:]) -> Int? {
        var table = preTable
        for out in d.patterns {
            if out.count == 2 { table[1] = out }
            if out.count == 3 { table[7] = out }
            if out.count == 4 { table[4] = out }
            if out.count == 7 { table[8] = out }
        }
        while table.count < 10 {
            var guesses: [Set<Character>: Set<Int>] = [:]
            for (known, pat) in table {
                for other in d.patterns {
                    guard !table.contains(where: { $0.value == other }) else { continue }
                    for digit in 0 ... 9 {
                        guard other.count == digits[digit].count else { continue }
                        if digits[digit].union(digits[known]).count == pat.union(other).count {
                            guesses[other] = guesses[other] ?? [digit]
                            guesses[other]?.insert(digit)
                        }
                    }
                }
            }
            let correctGuesses = guesses.filter { $0.value.count == 1 }
            if (correctGuesses.isEmpty) {
                for (pattern,values) in guesses {
                    for value in values where table[value] == nil {
                        table[value] = pattern
                        if let result = findAllKnownDigits(d: d, table:table) {
                            return result
                        }
                        table[value] = nil
                    }
                }
                return nil
            } else {
                correctGuesses.forEach {
                    table[$0.value.first!] = $0.key
                }
            }
        }
        guard test(d: d, table: table) else { return nil }
        let outputDigits = d.outputs.map { pattern in table.first(where: { $0.value == pattern })!.key }
        return Int(outputDigits[0] * 1000) +
            Int(outputDigits[1] * 100) +
            Int(outputDigits[2] * 10) +
            Int(outputDigits[3] * 1)
    }
    
    func test(d: DigitTest, table: [Int: Set<Character>]) -> Bool {
        for a in 0...9 {
            for b in 0...9 {
                guard digits[a].union(digits[b]).count == table[a]!.union(table[b]!).count  else { return false }
            }
        }
        return true
    }
}
