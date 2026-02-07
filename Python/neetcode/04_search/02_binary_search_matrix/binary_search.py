



def binary_search(data,target):

    c=len(data[0])
    r=len(data)
    l=0
    r=c*r-1

    while l<=r:
        m=(l+r)//2
        col=m%c
        row=m//c

        if data[row][col]==target:
            return True
        elif data[row][col]<target:
            l=m+1
        elif data[row][col]>target:
            r=m-1

    return False






if __name__=="__main__":


    matrix = [ [[1,3,5,7],[10,11,16,20],[23,30,34,60]], [[1,3,5,7],[10,11,16,20],[23,30,34,60]] ]
    target = [ 3, 13]


    for i in range(len(matrix)):
        out=binary_search(matrix[i],target[i])
        print("out: ",out)
