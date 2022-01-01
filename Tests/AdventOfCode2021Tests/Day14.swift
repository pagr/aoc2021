@testable import AdventOfCode2021
import Foundation
import XCTest

final class Day14Tests: XCTestCase {
    func testSmall() throws {
        let input = """
        NNCB

        CH -> B
        HH -> N
        CB -> H
        NH -> C
        HB -> C
        HC -> B
        HN -> C
        NN -> C
        BH -> H
        NC -> B
        NB -> B
        BN -> B
        BB -> N
        BC -> B
        CC -> N
        CN -> C
        """
        let d = Day14()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 1588)
        XCTAssertEqual(d.partB(input: data), 2188189693529)
    }
    
    func testReal() throws {
        let input = """
        SFBBNKKOHHHPFOFFSPFV

        HB -> C
        KO -> S
        KK -> N
        PF -> F
        VB -> F
        KC -> S
        BP -> H
        SS -> H
        BS -> B
        PB -> O
        VH -> C
        BK -> S
        BO -> F
        HN -> V
        NN -> K
        PV -> C
        NH -> P
        KP -> N
        NB -> V
        NF -> V
        PP -> O
        PN -> B
        VN -> K
        SC -> O
        NS -> N
        SV -> B
        BV -> P
        FV -> F
        OK -> H
        HF -> F
        CV -> K
        KB -> C
        OB -> B
        NO -> V
        OF -> B
        HP -> C
        BB -> F
        FB -> H
        OC -> K
        NV -> H
        OV -> S
        OP -> N
        SP -> N
        FK -> F
        VV -> B
        VK -> H
        OS -> F
        CO -> F
        CH -> V
        HV -> V
        FN -> B
        CS -> F
        PS -> F
        HS -> F
        VO -> K
        NP -> F
        FP -> B
        KF -> P
        CC -> N
        BF -> S
        VP -> F
        HO -> H
        FC -> F
        BH -> K
        NK -> S
        BN -> V
        SH -> K
        CP -> B
        VS -> K
        ON -> S
        FS -> P
        HK -> F
        PC -> O
        KN -> H
        CK -> N
        HH -> N
        CN -> S
        BC -> K
        PH -> N
        OO -> B
        FO -> O
        SK -> B
        FF -> V
        VC -> N
        SF -> N
        KH -> V
        SO -> F
        KS -> H
        SB -> K
        VF -> V
        PK -> O
        OH -> N
        HC -> F
        PO -> O
        NC -> F
        FH -> V
        KV -> V
        CB -> C
        CF -> O
        SN -> H
        """
        let d = Day14()
        let data = d.parse(input: input)
        XCTAssertEqual(d.partA(input: data), 4517)
        XCTAssertEqual(d.partB(input: data), 4704817645083)

        print(d.cache2.compactMap({ $0.value.count }))
//        d.partB(input: data)
    }
}
