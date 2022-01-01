@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day12Tests: XCTestCase {
    func testSmall() throws {
        let input = """
        start-A
        start-b
        A-c
        A-b
        b-d
        A-end
        b-end
        """
        let d = Day12()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 10)
        XCTAssertEqual(d.partB(input: data), 36)
    }
    
    func testMedium() throws {
        let input = """
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc
        """
        let d = Day12()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 19)
        XCTAssertEqual(d.partB(input: data), 103)
    }

    func testLarge() throws {
        let input = """
        fs-end
        he-DX
        fs-he
        start-DX
        pj-DX
        end-zg
        zg-sl
        zg-pj
        pj-he
        RW-he
        fs-DX
        pj-RW
        zg-RW
        start-pj
        he-WI
        zg-he
        pj-fs
        start-RW
        """
        let d = Day12()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 226)
        XCTAssertEqual(d.partB(input: data), 3509)
    }

    func testReal() throws {
        let input = """
        pg-CH
        pg-yd
        yd-start
        fe-hv
        bi-CH
        CH-yd
        end-bi
        fe-RY
        ng-CH
        fe-CH
        ng-pg
        hv-FL
        FL-fe
        hv-pg
        bi-hv
        CH-end
        hv-ng
        yd-ng
        pg-fe
        start-ng
        end-FL
        fe-bi
        FL-ks
        pg-start
        """
        let d = Day12()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 5958)
        XCTAssertEqual(d.partB(input: data), 150426)
    }
}
