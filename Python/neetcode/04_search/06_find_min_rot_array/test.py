



def find_min(arr):

    l=0
    r=len(arr)-1
    #temporary minimum
    mina=arr[0]


    while l<=r:

        # if I am in a portion that is ordered, then I will see that arr[l]<arr[r]
        # After I select the minimum I can just drop out immediately from this portion of array
        if arr[l]<arr[r]:
            mina=min(mina,arr[l])
            break

        #this is the portion that is not ordered and I know there is a rotated section inside it. 
        m=(l+r)//2
        mina=min(arr[m],mina)


        #this would be something like this [3,4,5,1,2]. if I am looking at the 5.
        #I know that because 5>3, then I am in the left portion of the rotated list.
        #so the minimum will be to the right of 5. 
        if arr[m]>=arr[l]:          
            l=m+1
        else:
            r=m-1

    return mina

        




if __name__=="__main__":

    test=[ [3,4,5,6,1,2],[4,5,0,1,2,3],[4,5,0,1,2,3],[2,1]]


    for p in test:
        mina=find_min(p)

        print("arr: {} min: {}".format(p,mina))
