import Foundation

class Day13 {
    typealias Position = Day9.Position
    enum Instruction {
        case vertical(Int)
        case horizontal(Int)
    }
    struct Input {
        let map: Set<Position>
        let instructions: [Instruction]
        
        init(map: Set<Position>, instructions: [Instruction]) {
            self.map = map
            self.instructions = instructions
        }
    }
    

    func parse(input: String) -> Input {
        let parts = input.components(separatedBy: "\n\n")
        
        let points = parts[0].split(separator: "\n").map { (s: Substring) -> Position in
            let parts = s.split(separator: ",")
            return Position(x: Int(String(parts[0]))!, y: Int(String(parts[1]))!)
        }
        let instructions = parts[1].split(separator: "\n").map { (s: Substring) -> Instruction in
            let parts = s.split(separator: " ")
                .last!
                .split(separator: "=")
            switch parts[0] {
            case "x": return Instruction.horizontal(Int(String(parts[1]))!)
            case "y": return Instruction.vertical(Int(String(parts[1]))!)
            default: fatalError()
            }
        }
        return Input(map: Set(points), instructions: instructions)
    }
    
    func partA(input: Input) -> Int {
        fold(input: input).map.count
    }
    
    func fold(input: Input) -> Input {
        let instruction = input.instructions.first
        let newPositions = input.map.compactMap { (p: Position) -> Position? in
            switch instruction {
            case .vertical(let y) where p.y == y:
                return nil
            case .horizontal(let x) where p.x == x:
                return nil
            case .vertical(let y) where p.y > y - 1:
                return Position(x: p.x, y: p.y - abs(y - p.y) * 2)
            case .horizontal(let x) where p.x > x - 1:
                return Position(x: p.x - abs(x - p.x) * 2, y: p.y)
            default:
                return p
            }
        }
        return Input(map: Set(newPositions), instructions: Array(input.instructions.dropFirst()))
    }
    
    func partB(input: Input) -> Int {
        var input = input
        while !input.instructions.isEmpty {
            input = fold(input: input)
            
        }
        printInput(input)
        return 0
    }
    
    func printInput(_ input: Input) {
        var s = ""
        let w = input.map.map(\.x).max()! + 1
        let h = input.map.map(\.y).max()! + 1
        for y in 0..<h {
            for x in 0..<w {
                if input.map.contains(Position(x: x, y: y)) {
                    s += "█"
                } else {
                    s += " "
                }
            }
            s += "\n"
        }
        print(s)
    }
    
}
