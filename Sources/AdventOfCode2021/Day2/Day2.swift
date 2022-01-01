import Foundation


struct Day2 {
    /*
     forward 5
     down 5
     forward 8
     up 3
     down 8
     forward 2
     */
    enum Instruction {
        case forward(Int)
        case up(Int)
        case down(Int)

        init(input: String) {
            let input = input.split(separator: " ")
            let int = Int(input[1])!
            switch String(input[0]) {
            case "forward": self = .forward(int)
            case "down": self = .down(int)
            case "up": self = .up(int)
            default: fatalError()
            }
        }
    }

    func parseInstructions(input: String) -> [Instruction] {
        input.split(separator: "\n").map { Instruction(input: String($0)) }
    }

    func apply(instructions: [Instruction]) -> Int {
        var x = 0
        var y = 0
        for instruction in instructions {
            switch instruction {
            case .forward(let int):
                 x += int
            case .up(let int):
                y -= int
            case .down(let int):
                y += int
            }
        }
        return x * y
    }

    func applyWithAim(instructions: [Instruction]) -> Int {
        var x = 0
        var y = 0
        var aim = 0
        for instruction in instructions {
            switch instruction {
            case .forward(let int):
                 x += int
                y += aim * int
            case .up(let int):
                aim -= int
            case .down(let int):
                aim += int
            }
        }
        return x * y
    }

}
