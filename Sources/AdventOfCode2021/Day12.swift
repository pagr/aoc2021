import Foundation

class Day12 {
    class Node {
        var name: String
        var connections: [Node]
        let isBig: Bool
        
        init(name: String, connections: [Node], isBig: Bool) {
            self.name = name
            self.connections = connections
            self.isBig = isBig
        }
    }

    struct Map {
        let start: Node
        let end: Node
        let nodes: [String: Node]
    }

    typealias Input = Map
    func parse(input: String) -> Input {
        let lines = input
            .split(separator: "\n")
            .map { (a: String($0.split(separator: "-")[0]), b: String($0.split(separator: "-")[1])) }
        
        var nodes: [String: Node] = [:]
        
        for line in lines {
            let a = nodes[line.a] ?? Node(name: line.a, connections: [], isBig: line.a.uppercased() == line.a)
            let b = nodes[line.b] ?? Node(name: line.b, connections: [], isBig: line.b.uppercased() == line.b)
            nodes[line.a] = a
            nodes[line.b] = b
            a.connections.append(b)
            b.connections.append(a)
        }
        return Map(start: nodes["start"]!, end: nodes["end"]!, nodes: nodes)
    }
    
    func partA(input: Input) -> Int {
        return countPaths(from: input.start)
    }
    
    func countPaths(from node: Node, visited: Set<String> = []) -> Int {
        var visited = visited
        if !node.isBig {
            visited.insert(node.name)
        }
        
        return node.connections
            .map {
                if $0.name == "end" { return 1 }
                if visited.contains($0.name) { return 0 }
                return countPaths(from: $0, visited: visited)
            }
            .reduce(0, +)
    }
    
    func partB(input: Input) -> Int {
        input.nodes.values
            .filter {
                if ["start", "end"].contains($0.name) { return false }
                return !$0.isBig
            }
            .map {
                countPaths2(from: input.start, requiredDoubleVisit: $0.name)
            }
            .reduce(countPaths(from: input.start), +)
    }
    
    func countPaths2(from node: Node, visited: [String: Int] = [:], requiredDoubleVisit: String) -> Int {
        var visited = visited
        if !node.isBig {
            visited[node.name] = (visited[node.name] ?? 0) + 1
        }
        
        return node.connections
            .map {
                if $0.name == "end" {
                    if visited[requiredDoubleVisit] == 2 {
                        return 1
                    } else {
                        return 0
                    }
                }
                if visited[$0.name] == (($0.name == requiredDoubleVisit) ? 2 : 1) { return 0 }
                return countPaths2(from: $0, visited: visited, requiredDoubleVisit: requiredDoubleVisit)
            }
            .reduce(0, +)
    }
}
