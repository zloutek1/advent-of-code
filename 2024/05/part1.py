
with open("../input/05/input.txt", 'r') as f:
    rules, orders = f.read().split("\n\n")
    rules = [list(map(int, r.split("|"))) for r in rules.strip().split("\n")]
    orders = [list(map(int, r.split(","))) for r in orders.strip().split("\n")]

before = {}
for (a, b) in rules:
    before.setdefault(a, [])
    before[a].append(b)

mids = []
for order in orders:
    correct = True
    for i in range(1, len(order)):
        for j in range(i):
            if order[j] in before.get(order[i], []):
                correct = False

    if correct:
        mid = order[len(order) // 2]
        mids.append(mid)

print(sum(mids))

