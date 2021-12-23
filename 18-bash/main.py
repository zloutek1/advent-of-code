from dataclasses import dataclass
from math import floor, ceil
import itertools

class Node:
    def __init__(self):
        self.parent = None
        self.left = None
        self.right = None
        self.value = None

    def is_leaf(self):
        return self.left is None and self.right is None

    def minimum(self):
        x = self
        while x.left is not None:
            x = x.left
        return x

    def maximim(self):
        x = self
        while x.right is not None:
            x = x.right
        return x

    def _tree_successor(self):
        if self.right is not None:
            return self.right.minimum()
        x = self
        y = x.parent
        while y is not None and x == y.right:
            x = y
            y = y.parent
        return y

    @property
    def successor(self):
        succ = self._tree_successor()
        if succ is not None:
            succ = succ._tree_successor()
        return succ

    def _tree_predecessor(self):
        if self.left is not None:
            return self.left.maximim()
        x = self
        y = x.parent
        while y is not None and x == y.left:
            x = y
            y = y.parent
        return y

    @property
    def predecessor(self):
        pred = self._tree_predecessor()
        if pred is not None:
            pred = pred._tree_predecessor()
        return pred

    def setValue(self, value):
        self.left = None
        self.right = None
        self.value = value

    @property
    def magnitude(self):
        if self.is_leaf():
            return self.value
        return 3 * self.left.magnitude + 2 * self.right.magnitude

    def __repr__(self):
        return f"{self.value}" if self.is_leaf() else f"({self.left}, {self.right})"

def toTree(numbers):
    def is_leaf(tree):
        return isinstance(tree, int)

    n = Node()
    if is_leaf(numbers):
        n.value = numbers
    else:
        n.left = toTree(numbers[0])
        n.left.parent = n

        n.right = toTree(numbers[1])
        n.right.parent = n
    return n

def reduce(tree):
    while True:
        tree, changed = try_to_explode(tree)
        if changed: continue

        tree, changed = try_to_split(tree)
        if not changed: break
    return tree


def try_to_explode(tree, depth=0):
    if tree.is_leaf():
        return tree, False

    if depth >= 4:
        explode(tree)
        return tree, True

    left, changed = try_to_explode(tree.left, depth+1)
    tree.left = left
    if changed: return tree, True

    right, changed = try_to_explode(tree.right, depth+1)
    tree.right = right
    if changed: return tree, True

    return tree, False

def explode(tree):
    if tree.left.predecessor:
        tree.left.predecessor.value += tree.left.value
    if tree.right.successor:
        tree.right.successor.value += tree.right.value
    tree.setValue(0)

def try_to_split(tree):
    if tree.is_leaf():
        if tree.value >= 10:
            split(tree)
            return tree, True
        return tree, False

    left, changed = try_to_split(tree.left)
    tree.left = left
    if changed: return tree, True

    right, changed = try_to_split(tree.right)
    tree.right = right
    if changed: return tree, True

    return tree, False

def split(tree):
    tree.left = Node()
    tree.left.value = floor(tree.value / 2)
    tree.left.parent = tree

    tree.right = Node()
    tree.right.value = ceil(tree.value / 2)
    tree.right.parent = tree

    tree.value = None

def add(left, right):
    tree = Node()
    tree.left = toTree(left) if isinstance(left, list) else left
    tree.left.parent = tree
    tree.right = toTree(right) if isinstance(right, list) else right
    tree.right.parent = tree

    return reduce(tree)

def addmany(*nums):
    left, *rest = nums
    for right in rest:
        left = add(left, right)
    return left

def part1(*nums):
    print("[Part1]", addmany(*nums).magnitude)

def part2(*nums):
    max_mag = 0
    for (left, right) in itertools.permutations(nums, 2):
        max_mag = max(max_mag, add(left, right).magnitude)
    print("[Part2]", max_mag)

def test(input, output):
    if isinstance(input, list):
        tree = toTree(input)
        reduced = reduce(tree)
    else:
        reduced = input
    assert str(reduced) == str(toTree(output)), f"{reduced} != {toTree(output)}"

test(input=[[[[[9,8],1],2],3],4], output=[[[[0,9],2],3],4])
test(input=[7,[6,[5,[4,[3,2]]]]], output=[7,[6,[5,[7,0]]]])
test(input=[[6,[5,[4,[3,2]]]],1], output=[[6,[5,[7,0]]],3])
test(input=[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]], output=[[3,[2,[8,0]]],[9,[5,[7,0]]]])

test(input=[10, 1], output=[[5,5], 1])
test(input=[11, 1], output=[[5,6], 1])
test(input=[12, 1], output=[[6,6], 1])

test(input=[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]], output=[[[[0,7],4],[[7,8],[6,0]]],[8,1]])

test(input=add([[[[4,3],4],4],[7,[[8,4],9]]], [1,1]), output=[[[[0,7],4],[[7,8],[6,0]]],[8,1]])

test(input=addmany([1,1],[2,2],[3,3],[4,4]), output=[[[[1,1],[2,2]],[3,3]],[4,4]])
test(input=addmany([1,1],[2,2],[3,3],[4,4],[5,5]), output=[[[[3,0],[5,3]],[4,4]],[5,5]])
test(input=addmany([1,1],[2,2],[3,3],[4,4],[5,5],[6,6]), output=[[[[5,0],[7,4]],[5,5]],[6,6]])

test(input=addmany([[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]],[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]],[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]],[7,[5,[[3,8],[1,4]]]],[[2,[2,2]],[8,[8,1]]],[2,9],[1,[[[9,3],9],[[9,0],[0,7]]]],[[[5,[7,4]],7],1],[[[[4,2],2],6],[8,7]]),
     output=[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]])

with open('input.txt') as f:
    nums = [eval(line) for line in f.readlines()]
    part1(*nums)
    part2(*nums)