
with open('../input/04/input.txt', 'r') as f:
    text = list(map(str.strip, f.readlines()))

def pprint(m):
    for row in m:
        for col in row:
            print(col, end=' ')
        print()

def diagonal(m):
    total = 0
    for i in range(len(m) - 2):
        for j in range(len(m[i]) - 2):
            left_window = m[i][j] + m[i+1][j+1] + m[i+2][j+2]
            right_window = m[i+2][j] + m[i+1][j+1] + m[i][j+2]

            total += (
                left_window in ("MAS", "SAM") and
                right_window in ("MAS", "SAM")
            )
    return total


pprint(text)
a = diagonal(text)
print(a)
