def parse_line(line):
    action, area = line.split()
    action = True if action == "on" else False
    xs, ys, zs = area.split(",")
    xl, xh = map(int, xs.split("=")[1].split(".."))
    yl, yh = map(int, ys.split("=")[1].split(".."))
    zl, zh = map(int, zs.split("=")[1].split(".."))
    return action, [(xl, xh), (yl, yh), (zl, zh)]

def eval_line(reactor, action, ranges, bounds):
    xs, ys, zs = ranges
    xl, xh, yl, yh, zl, zh = bounds

    def in_range(coords):
        x, y, z = coords
        return (xl <= x and x <= xh and
                yl <= y and y <= yh and
                zl <= z and z <= zh)

    if not any(map(in_range, zip(xs, ys, zs))):
        return reactor

    for z in range(zs[0], zs[1]+1):
        for y in range(ys[0], ys[1]+1):
            for x in range(xs[0], xs[1]+1):
                if in_range((x, y, z)):
                    reactor[(x, y, z)] = action
    return reactor

def part1(lines):
    reactor = {(x, y, z): False for x in range(101) for y in range(101) for z in range(101)}

    for line in lines:
        reactor = eval_line(reactor, *line, (-50, 50, -50, 50, -50, 50))

    on = sum(map(int, reactor.values()))
    print("[Part1]", on)

    return on

def part2(lines):
    on = 0

    xs = []
    ys = []
    zs = []

    for action, ranges in lines:
        xs.extend([*ranges[0]])
        ys.extend([*ranges[1]])
        zs.extend([*ranges[2]])

    xs = sorted(xs)
    ys = sorted(ys)
    zs = sorted(zs)

    reactor = {}

    on = 0
    for z1, z2 in zip(zs, zs[1:]):
        for y1, y2 in zip(ys, ys[1:]):
            for x1, x2 in zip(xs, xs[1:]):
                if reactor.get((x1, y1, z1), False):
                    on += (x2 - x1) * (y2 - y1) * (z2 - z1)

    print("[Part2]", on)

with open("example_input2.txt") as f:
    lines = []
    for line in f.readlines():
        lines.append(parse_line(line))

    part1(lines)
    part2(lines)
