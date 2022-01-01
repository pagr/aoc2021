import Foundation

func isPermutation(a: Int, b: Int) -> Bool {
    var c = [0,0,0,0,0,0,0,0,0,0]
    var a = a
    var b = b
    while a > 0 {
        c[a%10] += 1
        a = a / 10
    }
    while b > 0 {
        c[b%10] -= 1
        b = b / 10
    }
    c[0] = 0
    var res = true;
    for v in c {
        res = res && (v == 0)
    }
    return res
}

func phi(_ n: Int, primes: [Int], isPrime: [Bool]) -> Int {
    let factor = factorize(n, primes: primes, isPrime: isPrime)
        .map { 1 - 1 / Double($0)}
        .reduce(Double(n), *)
    return Int(factor.rounded())
}

var factorCache = Dictionary<Int, [Int]>()
func factorize(_ n: Int, primes: [Int], isPrime: [Bool]) -> [Int] {
    if n == 1 { return [1] }
    if isPrime[n] { return [n] }
    if let factors = factorCache[n] {
        return factors
    }
    var factors = [Int]()
    var n = n
    let original = n
    for i in primes {
        if n % i == 0 {
            factors += [i]
            while n % i == 0 {
                n = n / i
            }
            if let old = factorCache[n] {
                factors = old + factors
                break
            }
            if n == 1 { break }
            if isPrime[n] {
                factors += [n]
                break
            }
        }
    }
    factorCache[original] = factors
    return factors
}

func getPrimes(below max: Int) -> (primes: [Int], isPrime: [Bool]) {
    var primes = [Int]()
    var checked: [Bool] = Array(repeating: true, count: max + 1)

    for i in 2 ..< max {
        if checked[i]  {
            primes.append(i)
            let step = i
            for j in stride(from: i * i, to: max, by: step) {
                checked[j] = false
            }
        }
    }
    return (primes, checked)
}
