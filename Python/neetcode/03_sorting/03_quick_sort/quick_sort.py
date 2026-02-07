
from typing import List

class Pair:
    def __init__(self,key:int,val:str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key}, {self.val})"





class Solution:
    def QuickSort(self,pairs: List[Pair]) -> List[Pair]:
        self.QuickSortRec(pairs,0,len(pairs)-1)
        return pairs


    def QuickSortRec(self,arr,b,e):
        if e-b<=0:
            return


        pivot=arr[e]
        left=b

        for i in range (b,e):
            if arr[i].key<pivot.key:
                temp=arr[left]
                arr[left]=arr[i]
                arr[i]=temp
                left+=1

        arr[e] = arr[left]
        arr[left]=pivot

        self.QuickSortRec(arr,b,left-1)
        self.QuickSortRec(arr,left+1,e)



if __name__=="__main__":

    pairs= [
            [Pair(5, "apple"), Pair(9, "banana"), Pair(9, "cherry"), Pair(1, "date"), Pair(9, "elderberry")],
            [Pair(3, "cat"), Pair(2, "dog"), Pair(3, "bird")]
        ]

    sol=Solution()

    for i in pairs:
        print("original: ",i)
        out=sol.QuickSort(i)
        print("sorted:   ",out)
