from typing import List

class Pair:
    def __init__(self, key: int, val: str):
        self.key = key
        self.val = val

    def __repr__(self):
        return f"({self.key}, {self.val})"


def BucketSort(pairs: List[Pair]) -> List[Pair]:

    max_elem= max(pair.key for pair in pairs)

    buckets=[[] for i in range(max_elem+1)]


    for pair in pairs:
        buckets[pair.key].append(pair)

    sorted_list=[]
    for e in buckets:
        sorted_list.extend(e)

    return sorted_list
   


if __name__ == "__main__":
    pairs = [
        [Pair(5, "apple"), Pair(9, "banana"), Pair(9, "cherry"), Pair(1, "date"), Pair(9, "elderberry")],
        [Pair(3, "cat"), Pair(2, "dog"), Pair(3, "bird")]
    ]

    for i in pairs:
        print("original: ", i)
        out = BucketSort(i)
        print("sorted:   ", out)
