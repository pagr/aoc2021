//
//  File.swift
//  
//
//  Created by Paul Griffin on 2021-12-03.
//

import Foundation

class Day3 {

    func parseInput(input: String) -> [[Int]] {
        return input.split(separator: "\n").map { $0.map { Int(String($0))! } }
    }

    func getGamma(input: [[Int]]) -> [Int] {
        var counts: [Int] = []
        var result: [Int] = []
        for x in 0..<input[0].count {
            counts += [0]
            for y in 0..<input.count {
                if input[y][x] == 1 {
                    counts [x] += 1
                } else {
                    counts[x] -= 1
                }
            }
            if counts[x] > 0 {
                 result += [1]
            } else if counts[x] < 0 {
                 result += [0]
            } else {
                result += [1]
            }
        }
        return result
    }

    func getEpsilon(input: [[Int]]) -> [Int] {
        var counts: [Int] = []
        var result: [Int] = []
        for x in 0..<input[0].count {
            counts += [0]
            for y in 0..<input.count {
                if input[y][x] == 1 {
                    counts [x] += 1
                } else {
                    counts[x] -= 1
                }
            }
            if counts[x] > 0 {
                 result += [0]
            } else if counts[x] < 0 {
                 result += [1]
            } else {
                result += [0]
            }
        }
        return result
    }

    func getGammaEpsilon(input: [[Int]]) -> Int {
        let gamma = getGamma(input: input).map({String($0)}).joined()
        let epsilon = getEpsilon(input: input).map({String($0)}).joined()

        return Int(gamma, radix: 2)! * Int(epsilon, radix: 2)!
    }

    func filterToOne(input: [[Int]], oxygen: Bool) -> [Int] {
        var remaining = input
        for i in 0..<input[0].count {
            let commonBits = oxygen ? getGamma(input: remaining) : getEpsilon(input: remaining)
            let firstBit = commonBits[i]
            remaining = remaining.filter({ $0[i] == firstBit })
            if remaining.count == 1 {
                return remaining[0]
            }
        }
        fatalError()
    }

    func getOxygenCo2(input: [[Int]]) -> Int {
        let oxygen = filterToOne(input: input, oxygen: true).map({String($0)}).joined()
        let co2 = filterToOne(input: input, oxygen: false).map({String($0)}).joined()

        return Int(oxygen, radix: 2)! * Int(co2, radix: 2)!
    }
}
