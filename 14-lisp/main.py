from copy import copy
from collections import defaultdict, Counter

with open("input.txt") as f:
    content = f.read().split("\n")
    start, _, *rules = content
    rules = dict(tuple(rule.split(" -> ", 1)) for rule in rules)

    res = list(start)
    for _ in range(40):
        i = 0
        while i < len(res):
            for rule, to in rules.items():
                if res[i:i+2] == list(rule):
                    i += 1
                    res[i:i] = to
                    break
            i += 1

    c = Counter(res)
    print(max(c.values()) - min(c.values()))