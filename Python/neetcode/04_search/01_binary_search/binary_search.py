





def binary_search(data,target):

    l=0
    r=len(data)-1

    while l<=r:
        m=l+(r-l)//2

        if data[m]==target:
            return m
        elif data[m]<target:
            l=m+1
        elif data[m]>target:
            r=m-1

    return -1







if __name__=="__main__":

    data=[[1,2,3,3,4,5,6,7,8,9,10], [-1,0,2,4,6,8], [-1,0,2,4,6,8]]
    target = [3,4,3]

    
    for i in range(len(target)):
        out=binary_search(data[i],target[i])
        print("out: ",out)
