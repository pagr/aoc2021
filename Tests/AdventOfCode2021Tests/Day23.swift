@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day23Tests: XCTestCase {
    func testExampleA() throws {
        let d = Day23()
        let input = """
        #############
        #...........#
        ###B#C#B#D###
          #A#D#C#A#
          #########
        """
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 12521)
    }

    func testRealA() {
        let d = Day23()
        let input = """
        #############
        #...........#
        ###D#A#C#D###
          #B#C#B#A#
          #########
        """
        let data = d.parse(input: input)
        let a = d.partA(input: data)
        XCTAssertNotEqual(a, 18146)
        XCTAssertLessThan(a, 16926)
        XCTAssertLessThan(a, 14152)
        XCTAssertEqual(a, 14148)
    }


    func testExampleB() throws {
        let d = Day23b()
        let input = """
        #############
        #...........#
        ###B#C#B#D###
          #A#D#C#A#
          #########
        """
        let data = d.parse(input: input)
        XCTAssertEqual(d.partB(input: data), 44169)
    }

    func testRealB() {
        let d = Day23b()
        let input = """
        #############
        #...........#
        ###D#A#C#D###
          #B#C#B#A#
          #########
        """
        let data = d.parse(input: input)
        let a = d.partB(input: data)
        XCTAssertEqual(a, 43814)
    }
}
