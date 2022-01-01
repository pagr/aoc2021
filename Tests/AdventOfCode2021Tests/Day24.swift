@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day24Tests: XCTestCase {
    func testExample() throws {
        let d = Day24()
        let input = """
        inp x
        mul x -1
        """
        let program = d.parse(input: input)
        XCTAssertEqual(d.run(program: program, input: [1])[0], -1)
    }

    func testExample2() throws {
        let d = Day24()
        let input = """
        inp z
        inp x
        mul z 3
        eql z x
        """
        let program = d.parse(input: input)
        XCTAssertEqual(d.run(program: program, input: [1,3])[3], 1)
        XCTAssertEqual(d.run(program: program, input: [1,2])[3], 0)
    }
    func testExample3() throws {
        let d = Day24()
        let input = """
        inp w
        add z w
        mod z 2
        div w 2
        add y w
        mod y 2
        div w 2
        add x w
        mod x 2
        div w 2
        mod w 2
        """
        let program = d.parse(input: input)
        XCTAssertEqual(d.run(program: program, input: [1]), [0,0,0,1])
        XCTAssertEqual(d.run(program: program, input: [3]), [0,0,1,1])
        XCTAssertEqual(d.run(program: program, input: [5]), [0,1,0,1])
        XCTAssertEqual(d.run(program: program, input: [7]), [0,1,1,1])
        XCTAssertEqual(d.run(program: program, input: [8]), [1,0,0,0])
        XCTAssertEqual(d.run(program: program, input: [4]), [0,1,0,0])
    }

    func testReal() {
        let d = Day24()
        let input = """
        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 12
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 1
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 13
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 9
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 12
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 11
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -13
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 6
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 11
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 6
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 15
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 13
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -14
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 13
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 12
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 5
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -8
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 7
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 1
        add x 14
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 2
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -9
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 10
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -11
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 14
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -6
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 7
        mul y x
        add z y

        inp w
        mul x 0
        add x z
        mod x 26
        div z 26
        add x -5
        eql x w
        eql x 0
        mul y 0
        add y 25
        mul y x
        add y 1
        mul z y
        mul y 0
        add y w
        add y 1
        mul y x
        add z y
        """
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 96979989692495)
        XCTAssertEqual(d.partB(input: data), 0)
    }
}

