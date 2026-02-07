
class Pair:
    def __init__(self,key: int, val: str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key}, {self.val})"





def merge_sort(pairs):

    def merge_sort_helper(arr,b,e):

        if e-b<=1:
            return

        m=(b+e)//2

        merge_sort_helper(arr,b,m)
        merge_sort_helper(arr,m,e)

        merge(arr,b,m,e)


    def merge(arr,b,m,e):

        i=0 #pointer of L
        j=0 #pointer of R
        k=b #pointer of arr

        L=arr[b:m]
        R=arr[m:e]

        while i<len(L) and j<len(R):

            if L[i].key<=R[j].key:
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
                        
    
    merge_sort_helper(pairs,0,len(pairs))
    return pairs



if __name__=="__main__":

    pairs = [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry"), Pair(1, "date"), Pair(9, "elderberry")]
    print("original: ",pairs)
    out=merge_sort(pairs)
    print("sorted:   ",out)
        
