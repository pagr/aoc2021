@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day21Tests: XCTestCase {

    func testExample() throws {
        let d = Day21()
        let input = [4, 8]
//        """
//        Player 1 starting position: 4
//        Player 2 starting position: 8
//        """
        XCTAssertEqual(d.partA(input: input), 739785)
        XCTAssertEqual(d.partB(input: input), 444356092776315)
    }

    func testReal() {
        let d = Day21()
        let input = [8, 1]
//        """
//        Player 1 starting position: 8
//        Player 2 starting position: 1
//        """
        XCTAssertEqual(d.partA(input: input), 518418)
        XCTAssertEqual(d.partB(input: input), 116741133558209)
    }
}
