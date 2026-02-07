
class Pair:
    def __init__(self,key:int,val:str):
        self.key=key
        self.val=val

    def __repr__(self):
        return  f"({self.key}, {self.val})"




def quick_sort(arr):

    def quick_sort1(arr,b,e):

        if (e-b)<=0:
            return

        pivot=arr[e-1]
        pos=b

        for i in range(b,e-1):
            if arr[i].key<=pivot.key:
                temp=arr[pos]
                arr[pos]=arr[i]
                arr[i]=temp
                pos+=1

        #switch also the pivot
        arr[e-1]=arr[pos]
        arr[pos]=pivot


        quick_sort1(arr,b,pos)
        quick_sort1(arr,pos+1,e)

    quick_sort1(arr,0,len(arr))
    return arr
        




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
        
