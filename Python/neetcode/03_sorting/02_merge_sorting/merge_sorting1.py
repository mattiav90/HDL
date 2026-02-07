
class Pair:
    def __init__(self,key=int,val=str):
        self.key=key
        self.val=val

    def __repr__(self):
        return f"({self.key}, {self.val})"


# this is a recursive algorithm. merge sorting splits the array in 2 equal parts. 


def merge_sorting(arr):
    

    #recursive part.
    def merge_sorting1(arr,a,b):
        #base case of the recursion
        if b-a<=1:
            return

        m=(b+1)//2
        #keep splitting the array into half
        merge_sorting1(arr,a,m)
        merge_sorting1(arr,m,b)

        #when it hits the basecase it will start putting them together and ordering them
        sort(arr,a,m,b)


    #this is the actuall sorting mechanism.
    #compare the 2 splitter array and merge them with pointers.
    def sort(arr,a,m,b):

        L=arr[a:m]
        R=arr[m:b]

        i=0
        j=0
        k=0

        while i<len(L) and j<len(R):
            if L[i].key<= R[j].key:
                arr[k]=L[i]
                i+=1
            else:
                arr[k]=R[j]
                j+=1

            k+=1

        # when the first while ends, there might be one array with stuff inside. 
        #add it all. 
        if i<len(L):
            arr[k:b]=L[i:len(L)]

        if j<len(R):
            arr[k:b]=R[j:len(R)]
        
        

    merge_sorting1(arr,0,len(arr))
    return arr
 


if __name__=="__main__":

    pairs=[
            [Pair(1,"banana"),Pair(10,"dici"),Pair(4,"pillo")],
            [Pair(5, "apple"), Pair(2, "banana"), Pair(9, "cherry")],
            [Pair(3, "cat"), Pair(3, "bird"), Pair(2, "dog")]
        ]

    for p in pairs:
        print("original: ",p)
        out=merge_sorting(p)
        print("sorted:   ",out)
        print("\n")

