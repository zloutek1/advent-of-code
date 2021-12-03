
def calc_depth_increments(depths):
    increments = 0
    x, *xs = depths
    for y in xs:
        if x < y:
            increments += 1
        x = y
    return increments

def map_to_window(depths, size):
    for i in range(len(depths) - size + 1):
        yield sum(depths[i:i+size])

if __name__ == "__main__":
    with open("input.txt") as file:
        depths = [int(depth) for depth in file.read().split()]
    
        star1 = calc_depth_increments(depths)
        print("[star1]", star1)

        star2 = calc_depth_increments(map_to_window(depths, 3))
        print("[star2]", star2)
