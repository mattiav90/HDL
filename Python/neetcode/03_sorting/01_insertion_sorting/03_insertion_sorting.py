
class Pair:
    def __init__(self,key=int,val=str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key}, {self.val})"



def insertion_sorting(arr):


    for i in range(1,len(arr)):

        j=i-1
        val=arr[i]

        while j>=0 and arr[j].key>val.key:
            arr[j+1]=arr[j]
            j-=1

        arr[j+1]=val

    return arr
        


if __name__=="__main__":

    pairs=[
            [Pair(1,"banana"),Pair(10,"dici"),Pair(4,"pillo")],
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry")],
            [Pair(3, "cat"), Pair(3, "bird"), Pair(2, "dog")]
        ]

    for p in pairs:
        print("original: ",p)
        out=insertion_sorting(p)
        print("sorted:   ",out)
        print("\n")

