
class Pair:
    def __init__(self,key: int, val: str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key}, {self.val})"




# quick sort works similaarly to the merge sort, but instad of splitting in half
# i split looking at the pivot element.
# for this reason I am not guaranteed a time complexity of O(NlogN), but istead the worst case
# becomes O(N^2). but on average,usually it is more close to O(NlogN).
#this method, because performs swapping, it is unstable by default. 
#it could be augmented to become stable. 


# REMEMBER TO AVOID THE PIVOT. DO NOT USE THE "e" but use e-1.
def quick_sort(pairs):

    def quick_sort1(arr,b,e):
        if e-b<=1:
            return

        pivot=arr[e-1]
        left=b

        for i in range(b,e-1):
            if arr[i].key <= pivot.key:
                temp=arr[i]
                arr[i]=arr[left]
                arr[left]=temp
                left+=1


        arr[e-1]=arr[left]
        arr[left] = pivot


        quick_sort1(arr,b,left)
        quick_sort1(arr,left+1,e)
       
    

    quick_sort1(pairs,0,len(pairs))
    return pairs



if __name__=="__main__":

    pairs=[
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry"), Pair(1, "date"),Pair(4, "pollo"), Pair(9, "elderberry")],
            [Pair(1,"banana"),Pair(10,"dici"),Pair(4,"pillo")],
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry")],
            [Pair(3, "cat"), Pair(3, "bird"), Pair(2, "dog")]
        ]

    for p in pairs:
        print("original: ",p)
        out=quick_sort(p)
        print("sorted:   ",out)
        print("\n")
        
