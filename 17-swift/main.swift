import Foundation;

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

typealias Point = (x: Int, y: Int)
typealias Range2D = (xs: ClosedRange<Int>, ys: ClosedRange<Int>)
typealias Velocity = (x: Int, y: Int)

let gravity = 1

func drag(_ velocity: Velocity) -> Int {
    if velocity.x > 0 {
        return 1
    } else if velocity.x < 0 {
        return -1
    } else {
        return 0
    }
}

func radians(angle deg: Double) -> Double {
    return deg / 180 * Double.pi;
}

func doesHit(_ start: Point, _ goal: Range2D, velocity initial_velocity: Velocity) -> Bool {
    var current = start
    var velocity = initial_velocity
    while current.x <= goal.xs.upperBound && current.y >= goal.ys.lowerBound {
        current.x += velocity.x
        current.y += velocity.y
        velocity.x -= drag(velocity)
        velocity.y -= gravity

        if goal.xs.contains(current.x) && goal.ys.contains(current.y) {
            return true
        }
    }
    return false
}

func maxHeight(_ start: Point, velocity initial_velocity: Velocity) -> Point {
    var previous: Point? = nil
    var current = start
    var velocity = initial_velocity
    repeat {
        previous = current
        current.x += velocity.x
        current.y += velocity.y
        velocity.x -= drag(velocity)
        velocity.y -= gravity
    } while previous!.y < current.y
    return previous!
}

func solve(start: Point, goal: Range2D) {
    var largestHeight = Int.min
    var velocities: [Velocity] = []
    for y in -2000...2000 {
        for x in 0...2000 {
            if doesHit(start, goal, velocity: (x: x, y: y)) {
                let height = maxHeight(start, velocity: (x: x, y: y))
                if height.y > largestHeight {
                    largestHeight = height.y
                }
                velocities.append((x: x, y: y))
            }
        }
    }
    print("[Part1]", largestHeight)
    print("[Part2]", velocities.count)
}

func parseFile(filename: String) throws -> Range2D {
    let contents = try String(contentsOfFile: filename);
    let coords = contents.deletingPrefix("target area: ").components(separatedBy: ", ");
    let x_range = coords[0].deletingPrefix("x=").components(separatedBy: "..").map { Int($0)! };
    let y_range = coords[1].deletingPrefix("y=").components(separatedBy: "..").map { Int($0)! };

    return (xs: x_range[0] ... x_range[1],
            ys: y_range[0] ... y_range[1]);
}

let goal = try parseFile(filename: "input.txt")
solve(start: (x: 0, y: 0), goal: goal)