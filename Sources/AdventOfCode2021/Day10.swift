struct Day10 {
    enum Error: Swift.Error {
        case incorrectClose(e: String, f: String)
        case missingEnd(missing: String)
    }
    
    let brackets: [Character: String] = ["(": ")", "[": "]", "{": "}", "<": ">"]
    
    func parse(input: String) -> [String] {
        return input.components(separatedBy: "\n")
    }
    
    func autocompleteScore(input: [String]) -> Int {
        let result = input.compactMap { (s: String) -> Int? in
            do {
                let (_, missing) = try check(input: s)
                print("\(s) - \(missing) - \(score(missing: missing)) total points")
                return score(missing: missing)
            } catch {
                return nil
            }
        }
        .sorted()
        return result[result.count / 2]
    }
    
    func score(missing: String) -> Int {
        let costs: [Character: Int] = [")": 1, "]": 2, "}": 3, ">": 4]
        return missing.reduce(0) { (b: Int, a: Character) in costs[a]! + b * 5 }
    }
    
    func errorScore(input: [String]) -> Int {
        input
            .compactMap { (s: String) -> Int? in
                do {
                    _ = try check(input: s)
                    return nil
                } catch {
                    if case .incorrectClose(let e, let f) = error as? Error {
                        //print("- \(s) - expected \(e) but found \(f) instead")
                        return [")": 3,
                               "]": 57,
                               "}": 1197,
                               ">": 25137][f]!
                    }
                    return nil
                }
            }
            .reduce(0, +)
    }
    
    func check(input: String) throws -> (String, String) {
        if input.isEmpty { return ("", "") }
        
        let close = brackets[input.first!]!
        
        var result = String(input.dropFirst())
        var missing: String = ""
        while isOpen(result) {
            let newMissing: String
            (result, newMissing) = try check(input: result)
            missing += newMissing
        }
        if result.isEmpty {
            missing += close
        } else if !result.hasPrefix(close) {
            throw Error.incorrectClose(e: close, f: String(result.prefix(1)))
        }
        return (String(result.dropFirst()), missing)
    }
    func isOpen(_ s: String) -> Bool {
        s.count > 0 && brackets.keys.contains(s.first!)
    }
}
