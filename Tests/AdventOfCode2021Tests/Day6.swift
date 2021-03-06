@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day6Tests: XCTestCase {
    func testExample() throws {
        let d = Day6()
        let inpt: [Int] = [3, 4, 3, 1, 2]
        XCTAssertEqual(d.multiply(input: inpt, days: 80), 5934)
        XCTAssertEqual(d.multiply(input: inpt, days: 256), 26984457539)
    }

    func testReal() {
        let d = Day6()
        let input: [Int] = [
            3, 4, 1, 1, 5, 1, 3, 1, 1, 3, 5, 1, 1, 5, 3, 2, 4, 2, 2, 2, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 3, 1, 1, 5, 4, 1, 1, 1, 4, 1, 1, 1, 1, 2, 3, 2, 5, 1, 5, 1, 2, 1, 1, 1, 4, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, 3, 4, 2, 1, 3, 1, 1, 2, 1, 1, 2, 1, 5, 2, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 5, 1, 4, 1, 1, 1, 3, 3, 1, 3, 1, 3, 1, 4, 1, 1, 1, 1, 1, 4, 5, 1, 1, 3, 2, 2, 5, 5, 4, 3, 1, 2, 1, 1, 1, 4, 1, 3, 4, 1, 1, 1, 1, 2, 1, 1, 3, 2, 1, 1, 1, 1, 1, 4, 1, 1, 1, 4, 4, 5, 2, 1, 1, 1, 1, 1, 2, 4, 2, 1, 1, 1, 2, 1, 1, 2, 1, 5, 1, 5, 2, 5, 5, 1, 1, 3, 1, 4, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 4, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 5, 1, 1, 3, 5, 1, 1, 5, 5, 3, 5, 3, 4, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 5, 1, 3, 1, 5, 1, 1, 4, 1, 3, 1, 1, 1, 2, 1, 1, 1, 2, 1, 5, 1, 1, 1, 1, 4, 1, 3, 2, 3, 4, 1, 3, 5, 3, 4, 1, 4, 4, 4, 1, 3, 2, 4, 1, 4, 1, 1, 2, 1, 3, 1, 5, 5, 1, 5, 1, 1, 1, 5, 2, 1, 2, 3, 1, 4, 3, 3, 4, 3]

        XCTAssertEqual(d.multiply(input: input, days: 80), 379414)
        XCTAssertEqual(d.multiply(input: input, days: 256), 1705008653296)
    }
}
