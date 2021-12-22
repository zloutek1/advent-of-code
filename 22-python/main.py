reactor = [[[False for x in range(101)] for y in range(101)] for z in range(101)]

def parse_line(line):
    action, area = line.split()
    action = True if action == "on" else False
    xs, ys, zs = area.split(",")
    xl, xh = map(int, xs.split("=")[1].split(".."))
    yl, yh = map(int, ys.split("=")[1].split(".."))
    zl, zh = map(int, zs.split("=")[1].split(".."))
    return action, [(xl, xh), (yl, yh), (zl, zh)]

def in_range(coords):
    x, y, z = coords
    return (-50 <= x and x <= 50 and
            -50 <= y and y <= 50 and
            -50 <= z and z <= 50)

def eval_line(reactor, line):
    action, ranges = parse_line(line)
    xs, ys, zs = ranges

    if not any(map(in_range, zip(xs, ys, zs))):
        return reactor

    for z in range(zs[0], zs[1]+1):
        for y in range(ys[0], ys[1]+1):
            for x in range(xs[0], xs[1]+1):
                if in_range((x, y, z)):
                    reactor[z][y][x] = action
    return reactor

with open("example_input.txt") as f:
    for line in f.readlines():
        eval_line(reactor, line)

print(sum(sum(sum(int(cell) for cell in col) for col in row) for row in reactor))