
with open('../input/04/input.txt', 'r') as f:
    text = f.read().split("\n")

def pprint(m):
    for row in m:
        for col in row:
            print(col, end=' ')
        print()

def horizontal(m):
    total = 0
    for i in range(len(m)):
        for j in range(len(m[i]) - 3):
            window = m[i][j] + m[i][j+1] + m[i][j+2] + m[i][j+3]
            total += (window in ("XMAS", "SAMX"))
    return total

def vertical(m):
    total = 0
    for i in range(len(m) - 4):
        for j in range(len(m[i])):
            window = m[i][j] + m[i+1][j] + m[i+2][j] + m[i+3][j]
            total += (window in ("XMAS", "SAMX"))
    return total

def diagonal_left(m):
    total = 0
    for i in range(len(m) - 4):
        for j in range(len(m[i]) - 3):
            window = m[i][j] + m[i+1][j+1] + m[i+2][j+2] + m[i+3][j+3]
            total += (window in ("XMAS", "SAMX"))
    return total

def diagonal_right(m):
    total = 0
    for i in range(len(m) - 4):
        for j in range(len(m[i]) - 3):
            window = m[i][j+3] + m[i+1][j+2] + m[i+2][j+1] + m[i+3][j]
            total += (window in ("XMAS", "SAMX"))
    return total


pprint(text)
a = horizontal(text)
b = vertical(text)
c = diagonal_left(text)
d = diagonal_right(text)
print(a, b, c, d, a+b+c+d)
