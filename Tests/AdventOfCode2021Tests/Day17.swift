@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day17Tests: XCTestCase {

    func testExample2() throws {
        let d = Day17()
        let input = """
        target area: x=20..30, y=-10..-5
        """
        let data = d.parse(input: input)
//        XCTAssertEqual(d.simulate3(dx: 7, t: data), [4])
    }

    func testExample() throws {
        let d = Day17()
        let input = """
        target area: x=20..30, y=-10..-5
        """
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 45)
        XCTAssertEqual(d.partB(input: data), 112)
    }

    func testReal() {
        let d = Day17()
        let input = """
        target area: x=70..96, y=-179..-124
        """
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 15931)
        XCTAssertEqual(d.partB(input: data), 2555)
    }
}

