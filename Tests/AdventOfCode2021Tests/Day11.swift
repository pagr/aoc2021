@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day11Tests: XCTestCase {
    func testExample() throws {
        let input = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """
        let d = Day11()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 1656)
        XCTAssertEqual(d.partB(input: data), 195)
    }

    func testReal() throws {
        let input = """
        4585612331
        5863566433
        6714418611
        1746467322
        6161775644
        6581631662
        1247161817
        8312615113
        6751466142
        1161847732
        """
        let d = Day11()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 1571)
        XCTAssertEqual(d.partB(input: data), 387)
    }
}
