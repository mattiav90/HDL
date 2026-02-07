

def find_bin(arr,target):


    l=0
    r=len(arr)-1

    while l<=r:

        m=(l+r)//2

        if arr[m]==target:
            return m


        #if left side is sorted
        if arr[l]<arr[m]:
            if arr[l]<=target<arr[m]:
                r=m-1
            else:
                l=m+1

        #if right side is sorted:
        else:
            if arr[m]<target<arr[r]:
                l=m+1
            else:
                r=m-1
                

    return -1









if __name__ == "__main__":

    test=[[3,4,5,6,1,2],[3,5,6,0,1,2]]

    target=[1,4]

    for i,p in enumerate(test):
        out=find_bin(p,target[i])
        print("list: {} target: {} index: {}".format(p,target[i],out))

        
