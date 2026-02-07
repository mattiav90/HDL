
# basically pick one value in the list. pairs[i]
# if that value is smaller than any of the previous values, push the values forwars in sequence
# and then put at the beginning the key value. 

# [4,3,2,5,6]
# [4,4,2,5,6]
# [3,4,2,5,6]


# [3,4,2,5,6]
# [3,4,4,5,6]   notice the push to the right
# [3,3,4,5,6]
# [2,3,4,5,6]

# etch..





class Pair:
    def __init__(self,key: int, val: str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key} , '{self.val}')"


def insertion_sorting(pairs):
    out=[]
    
    for i in range (len(pairs)):

        j=i-1
        key=pairs[i]

        while j>=0 and pairs[j].key > key.key:
            pairs[j+1]=pairs[j]
            j-=1

        pairs[j+1]=key
        out.append(pairs[:])

    return out





if __name__=="__main__":

    pairs=[
            [Pair(1,"banana"),Pair(10,"dici"),Pair(4,"pillo")],
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry")],
            [Pair(3, "cat"), Pair(3, "bird"), Pair(2, "dog")]
        ]

    
    for i in pairs:
        out=insertion_sorting(i)
        print(out)
