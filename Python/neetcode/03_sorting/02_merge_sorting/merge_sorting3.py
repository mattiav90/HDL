

class Pair:
    def __init__(self,key: int, val: str):
        self.key=key
        self.val=val
    def __repr__(self):
        return f"[ {self.key} , {self.val} ]"



def merge_sort(arr):

    #
    def merge_sort1(arr,b,e):

        if (e-b)<=1:
            return

        m=(b+e)//2

        merge_sort1(arr,b,m)    
        merge_sort1(arr,m,e)

        sort(arr,b,m,e)


    def sort(arr,b,m,e):

        i=0
        j=0
        k=b
        
        L=arr[b:m]
        R=arr[m:e]

        while i<len(L) and j<len(R):
            if L[i].key<R[j].key:
                arr[k]=L[i]
                i+=1
            else:
                arr[k]=R[j]
                j+=1
            k+=1

        
        if i<len(L):
            arr[k:e]=L[i:len(L)]

        if j<len(R):
            arr[k:e]=R[j:len(R)]

    merge_sort1(arr,0,len(arr))
    return arr
             









if __name__=="__main__":

    pairs=[
            [Pair(1,"banana"),Pair(10,"dici"),Pair(4,"pillo")],
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry")],
            [Pair(3, "cat"), Pair(3, "bird"), Pair(2, "dog")]
        ]

    for p in pairs:
        print("original: ",p)
        out=merge_sort(p)
        print("sorted:   ",out)
        print("\n")

