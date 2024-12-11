
with open("../input/06/input.txt", 'r') as f:
    grid = [list(x) for x in f.read().strip().split("\n")]

def start_pos(grid):
    for y, row in enumerate(grid):
        for x, cel in enumerate(row):
            if cel == '^':
                return x, y
    return -1, -1

width, height = len(grid[0]), len(grid)
x, y = start_pos(grid)
dx, dy = 0, -1

seen = set()
seen.add((x, y))

while (0 <= x + dx and x + dx < width and 0 <= y + dy and y + dy < height):
    if grid[y+dy][x+dx] == '#':
        dx, dy = -1 * dy, 1 * dx

    x += dx
    y += dy
    seen.add((x, y))

print(len(seen))
