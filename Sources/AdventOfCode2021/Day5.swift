import Foundation


struct Day5 {
    typealias Line = (Point, Point)
    struct Point: Hashable {
        internal init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }

        let x: Int
        let y: Int

        init(input: String) {
            let parts = input.split(separator: ",")
            x = Int(parts[0])!
            y = Int(parts[1])!
        }
    }

    func parseInput(input: String) -> [Line] {
        //0,9 -> 5,9
        input.split(separator: "\n").map {
            let parts = $0.components(separatedBy: " -> ")
            return (Point(input: parts[0]), Point(input: parts[1]))
        }
    }

    func draw(lines: [Line]) -> Int {
        var image: Dictionary<Point, Int> = [:]

        for line in lines {
            if line.0.x == line.1.x {
                for y in min(line.0.y, line.1.y) ... max(line.0.y, line.1.y) {
                    image[Point(x: line.0.x, y: y)] = (image[Point(x: line.0.x, y: y)] ?? 0) + 1
                }
            }
            if line.0.y == line.1.y {
                for x in min(line.0.x, line.1.x) ... max(line.0.x, line.1.x) {
                    image[Point(x: x, y: line.0.y)] = (image[Point(x: x, y: line.0.y)] ?? 0) + 1
                }
            }
        }
        draw(image: image)
        return image.filter { $0.value > 1 }.count
    }

    func drawDiagonal(lines: [Line]) -> Int {
        var image: Dictionary<Point, Int> = [:]
        print("Drawing diagonal")
        for line in lines {
            if line.0.x == line.1.x {
                for y in min(line.0.y, line.1.y) ... max(line.0.y, line.1.y) {
                    image[Point(x: line.0.x, y: y)] = (image[Point(x: line.0.x, y: y)] ?? 0) + 1
                }
            } else if line.0.y == line.1.y {
                for x in min(line.0.x, line.1.x) ... max(line.0.x, line.1.x) {
                    image[Point(x: x, y: line.0.y)] = (image[Point(x: x, y: line.0.y)] ?? 0) + 1
                }
            } else {
                let yRange = stride(from: line.0.y, to: line.1.y + (line.0.y > line.1.y ? -1 : 1), by: line.0.y > line.1.y ? -1 : 1)
                let xRange = stride(from: line.0.x, to: line.1.x + (line.0.x > line.1.x ? -1 : 1), by: line.0.x > line.1.x ? -1 : 1)
                let pixels = zip(yRange, xRange)
                for (y,x) in pixels {
                    image[Point(x: x, y: y)] = (image[Point(x: x, y: y)] ?? 0) + 1
                }
            }
        }
        draw(image: image)
        return image.filter { $0.value > 1 }.count
    }

    func draw(image: Dictionary<Point, Int>) {
        var str: String = ""
        for y in 0..<10 {
            for x in 0..<10 {
                switch image[Point(x: x, y: y)] {
                case 0, nil: str += "."
                default: str += "\(image[Point(x: x, y: y)]!)"
                }
            }
            str += "\n"
        }
        print(str)
    }

}
