
from typing import List

class Pair:
    def __init__(self, key: int, val: str):
        self.key = key
        self.val = val

    def __repr__(self):
        return f"({self.key}, {self.val})"


def BucketSort(arr):

    maxx=max(p.key for p in arr)
    buck=[[] for _ in range(maxx+1)]

    for p in arr:
        buck[p.key].append(p)

    out=[]
    for e in buck:
        out.extend(e)

    return out
        



if __name__ == "__main__":
    pairs = [
        [Pair(5, "apple"), Pair(9, "banana"), Pair(9, "cherry"), Pair(1, "date"), Pair(9, "elderberry")],
        [Pair(3, "cat"), Pair(2, "dog"), Pair(3, "bird")]
    ]

    for i in pairs:
        print("original: ", i)
        out = BucketSort(i)
        print("sorted:   ", out)
        print("\n")
