import Foundation

class Day24 {
    typealias Input = [Instruction]
    typealias Position = Day9.Position

    enum Parameter {
        static let lookup: [String.SubSequence: Int] = ["w": 0, "x": 1, "y": 2, "z": 3]
        case number(Int)
        case reference(Int)
        init(_ s: String.SubSequence) {
            if let ref = Self.lookup[s] {
                self = .reference(ref)
            } else {
                self = .number(Int(s)!)
            }
        }

        func value(_ memory: [Int]) -> Int {
            switch self {
            case let .number(a): return a
            case let .reference(a): return memory[a]
            }
        }
    }

    enum Instruction {
        case input(Int)
        case add(Int, Parameter)
        case mul(Int, Parameter)
        case div(Int, Parameter)
        case mod(Int, Parameter)
        case eql(Int, Parameter)
        static let lookup: [String.SubSequence: Int] = ["w": 0, "x": 1, "y": 2, "z": 3]
        init(_ s: String.SubSequence) {
            let parts = s.split(separator: " ")
            switch parts[0] {
            case "inp": self = .input(Self.lookup[parts[1]]!)
            case "add": self = .add(Self.lookup[parts[1]]!, .init(parts[2]))
            case "mul": self = .mul(Self.lookup[parts[1]]!, .init(parts[2]))
            case "div": self = .div(Self.lookup[parts[1]]!, .init(parts[2]))
            case "mod": self = .mod(Self.lookup[parts[1]]!, .init(parts[2]))
            case "eql": self = .eql(Self.lookup[parts[1]]!, .init(parts[2]))
            default: fatalError()
            }
        }
    }

    func parse(input: String) -> Input {
        input.split(separator: "\n").map {
            Instruction($0)
        }
    }

    func run(program: Input, input: [Int]) -> [Int] {
        var program = program.makeIterator()
        return run(program: &program, memory: [0, 0, 0, 0], input: input)
    }

    func run(program: inout IndexingIterator<[Instruction]>, memory: [Int], input: [Int]) -> [Int] {
        var memory = memory
        var iterator = input.makeIterator()

        for i in program {
            switch i {
            case let .input(a):
                guard let next = iterator.next() else { return memory }
                memory[a] = next
            case let .add(a, b): memory[a] += b.value(memory)
            case let .mul(a, b): memory[a] *= b.value(memory)
            case let .div(a, b): memory[a] /= b.value(memory)
            case let .mod(a, b): memory[a] %= b.value(memory)
            case let .eql(a, b): memory[a] = (memory[a] == b.value(memory)) ? 1 : 0
            }
        }
        return memory
    }

    struct Tuple: Hashable {
        let z: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(z % 26)
            hasher.combine(z / 25)
        }

        static func == (lhs: Tuple, rhs: Tuple) -> Bool {
            return lhs.z % 26 == rhs.z % 26 &&
                lhs.z / 25 == rhs.z / 25
        }
    }

    func partA(input: Input) -> Int {
        partA2(input: input)
    }

    func runFast(w: Int, step: Int, z: Int) -> Int {
        var x = 0
        var y = 0
        var z = z

        let m = [1, 1, 1, 26, 1, 1, 26, 1, 26, 1, 26, 26, 26, 26]
        let a1 = [12, 13, 12, -13, 11, 15, -14, 12, -8, 14, -9, -11, -6, -5]
        let a2 = [1, 9, 11, 6, 6, 13, 13, 5, 7, 2, 10, 14, 7, 1]

        let i = step
//        inp w
//        mul x 0
        x = x * 0
//        add x z
        x = x + z
//        mod x 26
        x = x % 26
//        div z 1
        z = z / m[i]
//        add x 12
        x = x + a1[i]
//        eql x w
        x = x == w ? 1 : 0
//        eql x 0
        x = x == 0 ? 1 : 0
//        mul y 0
        y = y * 0
//        add y 25
        y = y + 25
//        mul y x
        y = y * x
//        add y 1
        y = y + 1
//        mul z y
        z = z * y
//        mul y 0
        y = y * 0
//        add y w
        y = y + w
//        add y 1
        y = y + a2[i]
//        mul y x
        y = y * x
//        add z y
        z = z + y

        // let i = step
        // inp w

        // mul x 0
        // add x z
        // mod x 26
        // add x 12
        // eql x w
        // eql x 0
        // x = (z % 26 + a1[i]) == w ? 0 : 1

        // mul y 0
        // add y 25
        // mul y x
        // add y 1
        // div z 1
        // mul z y
        // z = (z / m[i]) * (25 * x + 1)

        // mul y 0
        // add y w
        // add y 1
        // mul y x
        // y = (w + a2[i]) * x

        // add z y
        // z += y
        // }
        return z
    }

    func partA2(input program: Input) -> Int {
        var highest = [Tuple(z: 0): 0]
        var program = program.makeIterator()
        for d in 0 ..< 14 {
            var newhighest = [Tuple: Int]()
            for (k, v) in highest {
                for i in 1 ... 9 {
                    // let z = run(program: &program, memory: [0, 0, 0, k.z], input: [i])[3]
                    let z = runFast(w: i, step: d, z: k.z)
                    // assert(z == z2)
                    if d == 13 {
                        guard z == 0 else { continue }
                    }
                    if newhighest[Tuple(z: z)] ?? 0 < v * 10 + i {
                        newhighest[Tuple(z: z)] = v * 10 + i
                    }
                }
            }
            print("\(d + 1) - \(newhighest.count)")
            highest = newhighest
        }
        return highest.max(by: { $0.value < $1.value })!.value
    }

    func partB(input program: Input) -> Int {
        var highest = [Tuple(z: 0): 0]
        var program = program.makeIterator()
        for d in 0 ..< 14 {
            var newLowest = [Tuple: Int]()
            for (k, v) in highest {
                for i in 1 ... 9 {
                    // let z = run(program: &program, memory: [0, 0, 0, k.z], input: [i])[3]
                    let z = runFast(w: i, step: d, z: k.z)
                    // assert(z == z2)
                    if d == 13 {
                        guard z == 0 else { continue }
                    }
                    if newLowest[Tuple(z: z)] ?? Int.max > v * 10 + i {
                        newLowest[Tuple(z: z)] = v * 10 + i
                    }
                }
            }
            print("\(d + 1) - \(newLowest.count)")
            highest = newLowest
        }
        return highest.min(by: { $0.value < $1.value })!.value
    }
}
