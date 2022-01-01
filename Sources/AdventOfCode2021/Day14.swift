import Foundation

class Day14 {
    typealias Position = Day9.Position
    struct Rule {
        let l: Character
        let r: Character
        let add: Character
    }

    struct Input {
        internal init(initial: [Character], rules: [Day14.Rule]) {
            self.initial = initial
            self.rules = rules
        }
        
        let initial: [Character]
        let rules: [Rule]
    }
    
    func parse(input: String) -> Input {
        let parts = input.components(separatedBy: "\n\n")
        
        let initial = parts[0].map { $0 }
        let rules = parts[1].split(separator: "\n").map {
            Rule(l: $0.first!,
                 r: $0.dropFirst().first!,
                 add: $0.last!)
        }
        return Input(initial: initial, rules: rules)
    }
    
    func partA(input: Input) -> Int {
        performPolymerization(input: input, steps: 10)
    }
    
    func partB(input: Input) -> Int {
        performPolymerization(input: input, steps: 40)
    }
    
    func performPolymerization(input: Input, steps: Int) -> Int {
        let initial = Dictionary(grouping: input.initial.map { $0 }, by: { $0 }).mapValues { $0.count }
        let dicts = zip(input.initial.dropLast(), input.initial.dropFirst())
            .map { l, r in
                countInserted(l: l, r: r, rules: input.rules, steps: steps)
            }
        
        var dict = dicts.reduce([:]) { $0.merging($1, uniquingKeysWith: { $0 + $1 }) }
        dict = dict.merging(initial, uniquingKeysWith: { $0 + $1 })
        
        return dict.values.max()! - dict.values.min()!
    }
    
    var cache2: [Int: [String: [Character: Int]]] = [:]
    func countInserted(l: Character, r: Character, rules: [Rule], steps: Int) -> [Character: Int] {
        guard steps > 0 else { return [:] }
        let key = String([l, r])
        if let value = cache2[steps]?[key] { return value }
        
        guard let m = rules.first(where: { $0.l == l && $0.r == r })?.add else {
            if cache2[steps] == nil { cache2[steps] = [:] }
            cache2[steps]![key] = [:]
            return [:]
        }
        
        let a = countInserted(l: l, r: m, rules: rules, steps: steps - 1)
        let b = countInserted(l: m, r: r, rules: rules, steps: steps - 1)
        let result = a
            .merging(b, uniquingKeysWith: { $0 + $1 })
            .merging([m: 1], uniquingKeysWith: { $0 + $1 })
        
        if cache2[steps] == nil { cache2[steps] = [:] }
        cache2[steps]![key] = result
        return result
    }
}
